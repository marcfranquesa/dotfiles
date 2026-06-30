---
name: branch-worktrees
description: Use for non-main or PR branch work that should run in a temporary worktree.
---

## Rule

For branch or PR work outside `main`, create or reuse a temporary worktree
under `/tmp` and do the work there. Keep the primary checkout on `main` unless
explicitly told otherwise.

## Example

Review PR branch `feature/foo` in `/tmp/<repo>-feature-foo`, leaving the main
checkout on `main`.
