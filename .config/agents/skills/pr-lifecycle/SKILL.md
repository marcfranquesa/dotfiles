---
name: pr-lifecycle
description: Use when merging, closing, reopening, or retargeting PRs, or cleaning stale PR branches and worktrees.
---

## Rules

- Before any mutation, resolve the exact item and its author or owner. For batch
  operations, state the filtered target set before writing.
- Limit PR and issue mutations to items authored by `marcfranquesa` and within
  the user's explicit request. Limit branch and worktree mutations to items
  created or actively worked on in the current thread. Do not infer scope from
  repository or organization ownership, numeric ranges, or words such as
  "all".
- Treat third-party items as read-only unless the user explicitly names the
  exact item and requested mutation.
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
