# Repository Guidance

## Commit Scopes

For Conventional Commit scopes in this repo, prefer touched-area names such as
`shell`, `git`, `tmux`, `nvim`, `bootstrap`, `docs`, or `skills`. Omit the
scope when it adds no clarity.

## Branch Workspaces

- When asked to work from a branch other than `main`, use a temporary worktree
  under `/tmp` for that branch.
- This includes opening, updating, reviewing, or fixing PRs.
- Keep the main checkout on `main` unless explicitly asked otherwise.

## Pull Requests

- Squash merge PRs.
- After merging a PR, delete the stale branch from both the remote and local
  repository.

## Comments

- Prefer clear names and structure over comments.
- Comment why a choice exists, what constraint matters, or what is surprising.
- Do not restate obvious code.
- Update or delete stale comments in the same change that makes them stale.
- Use sentence case for prose comments: capitalize the first word, preserve
  identifier casing, and end complete sentences with periods.
- Use complete sentences for block comments.
- Keep inline comments short and rare; use the same capitalization and
  punctuation rules.
- Use `TODO(scope): Action.` only for concrete follow-up work. Keep `TODO`
  uppercase and `scope` lower-case.
