# Repository Guidance

## Commit Messages

Use Conventional Commits:

```text
type(scope): imperative summary
```

- Use `feat`, `fix`, `docs`, `refactor`, `style`, `test`, `build`, `ci`, or
  `chore`.
- Pick one short scope from the touched area, such as `shell`, `git`, `tmux`,
  `nvim`, `bootstrap`, or `docs`. Omit the scope only when it adds no clarity.
- Keep `type` and `scope` lower-case. Use `: ` after the scope.
- Write the summary in imperative mood, lower-case, with no trailing period.
- Aim for about 50 characters; keep the full subject under 72.
- Add a blank-line body only when the reason or side effect is not obvious
  from the diff; wrap body lines at about 72 characters.
- Keep commits logically separate. If one message needs "and", consider
  splitting the commit.

Examples:

```text
chore(shell): set AI config dirs
docs: document commit message style
fix(tmux): limit auto attach to terminal logins
```

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
