---
name: agent-config-sync
description: "Use in this dotfiles repository when changes touch shared agent config: `.config/agents`, `.config/codex`, `.config/claude`, shared skills, AGENTS/CLAUDE guidance files, or related ignore rules. Keeps `.config/agents` canonical, adapters symlink or import from it, and shared instructions agent-neutral."
---

# Agent Config Sync

Use this before changing or committing `.config/agents`, `.config/codex`, or
`.config/claude`.

## Rules

- Keep `.config/agents` as canonical shared source.
- Treat `.config/codex` and `.config/claude` as adapters: symlink shared
  skill dirs, import or symlink shared guidance, and keep only local exceptions
  there.
- Keep shared instructions agent-neutral; name a specific assistant only when
  that tool is the subject.
- Keep runtime-managed adapter trees ignored; unignore only intentional shared
  sources and adapter links or wrappers.

For a shared skill:

```sh
ln -s ../../agents/skills/<skill-name> .config/codex/skills/<skill-name>
ln -s ../../agents/skills/<skill-name> .config/claude/skills/<skill-name>
```

For shared guidance, keep `.config/agents/AGENTS.md` canonical and import it
from wrappers that need local exceptions:

```md
@../agents/AGENTS.md
```

## Verification

Before finishing, run only checks matching touched files:

```sh
git status --short --untracked-files=all
test -L .config/codex/skills/<skill-name>
test -L .config/claude/skills/<skill-name>
git check-ignore -v .config/agents/skills/<skill-name>/SKILL.md \
  .config/codex/skills/<skill-name> \
  .config/claude/skills/<skill-name>
git check-ignore -v .config/agents/AGENTS.md \
  .config/codex/AGENTS.md \
  .config/claude/CLAUDE.md
```

In `git check-ignore -v`, a matching `!` rule means the path was intentionally
unignored.
