---
name: pr-merge-cleanup
description: Use when merging PRs or cleaning stale PR branches/worktrees.
---

## Rule

Squash merge PRs unless the user or repository explicitly requires another
merge strategy. After merge, delete the remote and local head branches when
they exist and are safe to remove, and remove any associated worktree.

## Example

PR #42 merges `feature-x` into `main`: squash merge it, delete
`origin/feature-x`, delete local `feature-x` only if safe, remove its `/tmp`
worktree, and report anything left behind.
