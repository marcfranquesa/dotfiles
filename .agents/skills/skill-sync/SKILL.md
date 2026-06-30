---
name: skill-sync
description: Use in this dotfiles repository when creating, moving, copying, installing, updating, reviewing, or committing shared personal agent skills, or when a commit/status/diff touches `.config/agents`, `.config/codex`, or `.config/claude`. Ensures `.config/agents/skills` remains the source of truth, Codex and Claude get relative symlinks, and git tracks only shared skill sources plus tool-specific skill links while runtime-managed trees stay ignored.
---

# Skill Sync

Use this skill before adding or changing shared personal skills in this repo.
Also use it before committing when `git status` or a diff touches
`.config/agents`, `.config/codex`, or `.config/claude`.

## Rule

Keep `.config/agents/skills/<skill-name>` as the canonical source.

Expose the same skill to each tool with relative symlinks:

```sh
ln -s ../../agents/skills/<skill-name> .config/codex/skills/<skill-name>
ln -s ../../agents/skills/<skill-name> .config/claude/skills/<skill-name>
```

Do not copy skill files into `.config/codex/skills` or `.config/claude/skills`.
Those directories are compatibility and discovery layers, not separate source
trees.

## Git Shape

The intended tracked files are:

- `.config/agents/skills/<skill-name>/**`
- `.config/codex/skills/<skill-name>` as a symlink
- `.config/claude/skills/<skill-name>` as a symlink

Keep the rest of `.config/codex/**` and `.config/claude/**` ignored because
those trees contain runtime-managed state.

## Commit Check

When preparing a commit that touches `.config/agents`, `.config/codex`, or
`.config/claude`, confirm the diff preserves the source/link split:

- shared skill contents live under `.config/agents/skills/`;
- Codex and Claude skill entries are relative symlinks;
- runtime-managed Codex or Claude files are not staged accidentally.

## Verification

From the repo root, verify the shape before finishing:

```sh
test -L .config/codex/skills/<skill-name>
test -L .config/claude/skills/<skill-name>
git check-ignore -v .config/agents/skills/<skill-name>/SKILL.md \
  .config/codex/skills/<skill-name> \
  .config/claude/skills/<skill-name>
git status --short --untracked-files=all
```

In verbose output, a matching `!` rule means the path was intentionally
unignored.

For an exit-code check, use a loop variable that is not `path` because `path`
is special in `zsh`:

```sh
for p in .config/agents/skills/<skill-name>/SKILL.md \
  .config/codex/skills/<skill-name> \
  .config/claude/skills/<skill-name>; do
  git check-ignore -q "$p" && echo "ignored: $p"
done
```

That loop should produce no output for the shared source file and the two
symlinks. If it reports any of them as ignored, fix `.gitignore` before
reporting the change as done.
