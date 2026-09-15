# Linked PDF windows in tmux

Open a PDF from a Neovim pane with `<Space>o` or forward search with `Enter`.
`open-compiled` remembers its absolute path in that pane's `@zathura_pdf` option.
When switching tmux windows or panes, the matching open Zathura window is raised.
Keyboard focus stays in Neovim; the PDF page and scroll position stay unchanged.
Closed PDFs and panes without a link are left alone.

This macOS integration uses the default full-path Zathura window title.
Allow the terminal app to control System Events and enable its Accessibility
access in System Settings if macOS requests it. No PDF windows are launched by
the switching hook.

After installing these dotfiles, reload with `tmux source-file ~/.config/tmux/tmux.conf`
and reopen each PDF once from its editor pane to establish the link.

## Editing and compiling

- `<Space>c`: save the current source and compile. Run from the document's project
  directory so relative `\input` and bibliography paths resolve correctly.
- `<Space>o`: open the existing PDF.
- `Enter`: forward search to the source line; requires a `.synctex.gz` or
  uncompressed `.synctex` file alongside the PDF.
- `Ctrl` + left-click in Zathura: return to the linked Neovim source buffer.
  Unsaved buffers stay unsaved. If that editor has closed, the click does not
  jump into another editor.

Opening a PDF never compiles it. Compile explicitly after editing. PDF lookup
uses the source's sibling PDF, then the nearest ancestor `main.pdf`; it stops at
an unbuilt `main.tex` or repository boundary instead of choosing an arbitrary
PDF. Projects with a differently named root should open that root source first.

Viewer failures are reported by Neovim instead of silently opening an
unsynchronized PDF. Compilation stops on the first failed pass rather than
continuing with stale output. The existing pdfLaTeX/BibTeX/Biber workflow remains;
no new build manager is required.

## macOS installation checks

The PDF backend is a separate plugin. After reinstalling Zathura, restore its link:

```sh
mkdir -p /opt/homebrew/opt/zathura/lib/zathura
ln -sf /opt/homebrew/opt/zathura-pdf-poppler/libpdf-poppler.dylib \
  /opt/homebrew/opt/zathura/lib/zathura/libpdf-poppler.dylib
zathura --version
```

Forward search also needs the session D-Bus service. Load the plist shipped by
Homebrew once (it persists across logins):

```sh
mkdir -p ~/Library/LaunchAgents
cp /opt/homebrew/opt/dbus/org.freedesktop.dbus-session.plist ~/Library/LaunchAgents/
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/org.freedesktop.dbus-session.plist
```

On this Mac, Zathura 2026.02.09 is pinned and built against TeX Live's SyncTeX 2
library. The tap's optional `synctex` formula reports 1.21, which this Zathura
version silently ignores—even with `--with-synctex`. Check the actual binary:

```sh
otool -L /opt/homebrew/bin/zathura | rg synctex
```

To reproduce that build, the Zathura formula needs an explicit `with-synctex`
option, `depends_on "texlive" if build.with? "synctex"` instead of the optional
`synctex` dependency, and `-Dsynctex=enabled` in its Meson arguments. The latter
makes a missing library a build failure. Restore the upstream formula after
building, restore the PDF-plugin link, and retain the pin until the upstream
recipe supports SyncTeX 2. Do not replace it with an ordinary reinstall without
checking the resulting binary.

## Checks

Run `python3 bootstrap/check_zathura.py -v`. These use a fake viewer and a
real isolated Neovim process; they do not touch your documents or GUI windows.
