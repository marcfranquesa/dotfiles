---
name: pr-lifecycle
description: Use when merging, closing, reopening, or retargeting PRs, or cleaning stale PR branches and worktrees.
---

## Rules

- Resolve the exact item and its author or owner before any mutation. Apply
  the [shared GitHub mutation scope](../../AGENTS.md#github-mutation-scope).
- Squash merge PRs unless the user or repository explicitly requires another
  merge strategy.
- Before merging after a rebase, force-push, retarget, or similar history
  rewrite, compare the rewritten branch with both its previous tip and the
  current target branch. Verify that intended PR changes remain and that the
  result does not undo commits that recently landed on the target; stop on any
  unexplained dropped commit or reverted change.
- After merge, delete the remote and local head branches when they exist and
  are safe to remove, and remove any associated worktree.

## Example

PR #42 merges `feature-x` into `main`: squash merge it, delete
`origin/feature-x`, delete local `feature-x` only if safe, remove its `/tmp`
worktree, and report anything left behind.
