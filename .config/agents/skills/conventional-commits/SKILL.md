---
name: conventional-commits
description: Enforce Conventional Commit messages for git commits, message review or rewrite, editable squash or merge titles, PR squash titles, and Conventional-Commit-style changelog entries.
---

# Conventional Commits

## Rule

Use `<type>[optional scope][optional !]: <description>`, with any body or
footer block after a blank line.

Default to `feat`, `fix`, `docs`, `refactor`, `style`, `test`, `build`, `ci`,
`chore`, `perf`, or `revert`. Use non-listed types only when local instructions
define them. `feat` adds capability; `fix` corrects a bug.

## Style

- Scope: short noun, only when useful; prefer repo-local scope guidance.
- Description: imperative, lower-case unless casing is required, no trailing
  period, and under 72 characters.
- Use git-trailer-style footers.

## Breaking Changes

House style: breaking changes use both `!` before the colon and a blank-line
`BREAKING CHANGE:` footer. Breaking changes can use any type.

## Guardrails

- Inspect the change; do not commit unrelated files.
- Rewrite invalid user-provided messages unless the user insists; then surface
  the conflict.
- Apply to editable squash/merge titles and compatible repo-local constraints.

## Examples

```text
feat(parser): add quoted field support
refactor(config)!: remove legacy config format

BREAKING CHANGE: legacy config files must be migrated before upgrading
```
