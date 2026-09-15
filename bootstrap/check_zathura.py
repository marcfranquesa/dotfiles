"""Run with python3 bootstrap/check_zathura.py; requires nvim for inverse search."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import time
import unittest

BIN = Path(__file__).resolve().parents[1] / '.local/bin'


class ZathuraWorkflow(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='zathura-')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        self.project = self.root / 'project with spaces'
        self.project.mkdir()
        (self.project / '.git').mkdir()
        self.source = self.project / 'main.tex'
        self.source.write_text('first\nsecond\nthird\n')
        self.pdf = self.source.with_suffix('.pdf')
        self.pdf.write_text('PDF fixture')
        self.mockbin = self.root / 'bin'
        self.mockbin.mkdir()
        self.log = self.root / 'viewer.json'
        self.env = dict(os.environ, PATH=f'{self.mockbin}:{os.environ["PATH"]}',
                        VIEWER_LOG=str(self.log), TMUX_PANE='', NVIM_SERVER='',
                        NVIM='', NVIM_PIPE='', XDG_RUNTIME_DIR=str(self.root / 'runtime'))
        viewer = self.mockbin / 'zathura'
        viewer.write_text('#!/usr/bin/env python3\nimport json,os,sys\n'
                          'open(os.environ["VIEWER_LOG"],"w").write(json.dumps(sys.argv[1:]))\n'
                          'print("viewer test error",file=sys.stderr)\n'
                          'sys.exit(int(os.environ.get("VIEWER_EXIT","0")))\n')
        viewer.chmod(0o755)
        compiler = self.mockbin / 'compile'
        compiler.write_text('#!/bin/sh\ntouch "$VIEWER_LOG.compiled"\nexit 1\n')
        compiler.chmod(0o755)

    def call(self, script, *args, **env):
        return subprocess.run([str(BIN / script), *map(str, args)], env=dict(self.env, **env),
                              cwd=self.project, text=True, capture_output=True, timeout=10)

    def test_nested_source_and_spaced_path(self):
        section = self.project / 'sections' / 'part.tex'
        section.parent.mkdir()
        section.write_text('section')
        result = self.call('open-compiled', section)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(json.loads(self.log.read_text())[-1], str(self.pdf))

    def test_never_select_an_unrelated_pdf(self):
        self.pdf.rename(self.project / 'unrelated.pdf')
        (self.root / 'main.pdf').write_text('another project')
        result = self.call('open-compiled', self.source)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('compile the document first', result.stderr)
        self.assertFalse(self.log.exists())

    def test_repository_boundary(self):
        self.pdf.unlink()
        self.source.rename(self.project / 'part.tex')
        (self.root / 'main.pdf').write_text('another project')
        result = self.call('open-compiled', self.project / 'part.tex')
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(self.log.exists())

    def test_forward_search_requires_metadata_without_compiling(self):
        result = self.call('open-compiled', self.source, 2, 1)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('SyncTeX data missing', result.stderr)
        self.assertFalse(Path(str(self.log) + '.compiled').exists())
        self.source.with_suffix('.synctex').write_text('uncompressed metadata')
        result = self.call('open-compiled', self.source, 2, 1)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn(f'--synctex-forward=2:1:{self.source}', json.loads(self.log.read_text()))

    def test_viewer_failure_is_visible(self):
        result = self.call('open-compiled', self.source, VIEWER_EXIT='7')
        self.assertEqual(result.returncode, 7)
        self.assertIn('viewer test error', result.stderr)

    def test_failed_make_does_not_fall_back_to_pdflatex(self):
        (self.project / 'Makefile').write_text('fixture')
        make = self.mockbin / 'make'
        make.write_text('#!/bin/sh\nexit 12\n')
        make.chmod(0o755)
        self.assertEqual(self.call('compile', self.source).returncode, 12)

    def test_compiler_quotes_paths_and_stops_after_failure(self):
        self.source.write_text('\\documentclass{article}\n')
        compiler = self.mockbin / 'pdflatex'
        compiler.write_text('#!/usr/bin/env python3\nimport json,os,sys\n'
                            'with open(os.environ["VIEWER_LOG"],"a") as f: f.write(json.dumps(sys.argv[1:])+"\\n")\n'
                            'sys.exit(int(os.environ.get("VIEWER_EXIT","0")))\n')
        compiler.chmod(0o755)
        result = self.call('compile', self.source)
        self.assertEqual(result.returncode, 0, result.stderr)
        calls = [json.loads(line) for line in self.log.read_text().splitlines()]
        self.assertEqual(len(calls), 2)
        self.assertEqual(calls[-1][-1], str(self.source))
        self.assertIn('-synctex=1', calls[-1])
        self.log.unlink()
        result = self.call('compile', self.source, VIEWER_EXIT='9')
        self.assertEqual(result.returncode, 9)
        self.assertEqual(len(self.log.read_text().splitlines()), 1)

    def test_bibliography_uses_a_relative_stem(self):
        self.source = self.project / 'tex/main.tex'
        self.source.parent.mkdir()
        self.source.write_text('\\documentclass{article}\n\\bibliography{refs}\n')
        for name in ('pdflatex', 'bibtex'):
            tool = self.mockbin / name
            tool.write_text('#!/usr/bin/env python3\nimport json,os,sys\n'
                            'with open(os.environ["VIEWER_LOG"],"a") as f: f.write(json.dumps([sys.argv[0],os.getcwd(),sys.argv[1:]])+"\\n")\n')
            tool.chmod(0o755)
        result = self.call('compile', self.source)
        self.assertEqual(result.returncode, 0, result.stderr)
        calls = [json.loads(line) for line in self.log.read_text().splitlines()]
        bibliography = next(call for call in calls if call[0].endswith('/bibtex'))
        self.assertEqual(bibliography[1:], [str(self.source.parent), ['main']])
        latex = next(call for call in calls if call[0].endswith('/pdflatex'))
        self.assertEqual(latex[1], str(self.project))

    def test_inverse_search_preserves_unsaved_buffers_and_closed_links(self):
        socket = self.root / 'runtime/nvim/shell-test.pipe'
        socket.parent.mkdir(parents=True)
        editor = subprocess.Popen(['nvim', '--clean', '--headless', '--listen', str(socket), str(self.source)],
                                  env=self.env, cwd=self.project, stdout=subprocess.DEVNULL,
                                  stderr=subprocess.DEVNULL)
        self.addCleanup(lambda: editor.poll() is None and editor.terminate())
        def rpc(expr):
            return subprocess.check_output(['nvim', '--server', str(socket), '--remote-expr', expr],
                                           text=True, stderr=subprocess.DEVNULL, timeout=5)
        for _ in range(100):
            if socket.exists():
                break
            time.sleep(0.02)
        self.assertTrue(socket.exists())
        rpc('setline(1, "unsaved")')
        result = self.call('_zathura_inverse', f'--server={socket}', 3, -1, self.source)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(json.loads(rpc('json_encode([line("."),col("."),&modified,getline(1)])')),
                         [3, 1, 1, 'unsaved'])
        other = self.project / "another author's file.tex"
        other.write_text('one\ntwo\n')
        self.assertEqual(self.call('_zathura_inverse', f'--server={socket}', 2, 1, other).returncode, 0)
        self.assertEqual(self.call('_zathura_inverse', f'--server={socket}', 2, 1, self.source).returncode, 0)
        self.assertEqual(json.loads(rpc('json_encode([&modified,getline(1)])')), [1, 'unsaved'])
        self.assertEqual(self.source.read_text(), 'first\nsecond\nthird\n')
        result = self.call('_zathura_inverse', '--server=/tmp/nonexistent-zathura-editor', 1, 1, self.source)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(rpc('line(".")'), '2')
        editor.terminate()
        editor.wait(timeout=5)


if __name__ == '__main__':
    unittest.main()
