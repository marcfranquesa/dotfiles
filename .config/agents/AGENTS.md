# Shared Agent Guidance

## Python Environments

Do not install Python packages into system, Homebrew, distro, or other global
Python environments, including with `sudo pip`, `pip install --user`, or
`--break-system-packages`. Use the project's declared environment manager
first. For one-off Python tools, prefer `uvx` or `uv run --with ...`; for Pixi
projects, prefer `pixi run`.
