# Shared Agent Guidance

## Python Environments

Do not install Python packages into system, Homebrew, distro, or other global
Python environments, including with `sudo pip`, `pip install --user`, or
`--break-system-packages`. Use the project's declared environment manager
first. For one-off Python tools, prefer `uvx` or `uv run --with ...`; for Pixi
projects, prefer `pixi run`.

## Working Defaults

- Do branch/PR work outside `main` in a temporary `/tmp` worktree; keep the primary checkout on `main` unless told otherwise.
- Use `/tmp` for temporary repo clones or inspection checkouts, and delete them when done.
- Prefer clear code over comments; keep comments for why, constraints, or surprising behavior, and update or delete stale comments.
