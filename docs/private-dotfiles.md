# Private dotfiles with chezmoi

This public repository owns chezmoi's configuration through Stow. The private
`marcfranquesa/dotfiles-private` repository owns the SSH client config only.
Private keys, known hosts, and SSH agent files are not managed by either repo.

## Paths

The shell environment defines the standard XDG base directories. Chezmoi uses
the default source and cache locations; its config moves the state database out
of the configuration directory:

| Purpose | Path |
| --- | --- |
| Tool config (public, Stow-managed) | `~/.config/chezmoi/chezmoi.toml` |
| Private Git checkout | `~/.local/share/chezmoi` |
| Persistent state | `~/.local/state/chezmoi/chezmoi.boltdb` |
| Cache | `~/.cache/chezmoi` |
| Applied SSH config | `~/.ssh/config` |

The state path follows the fixed `XDG_STATE_HOME` in `.config/shell/env`.
If that base directory changes, update `persistentState` too; chezmoi does not
expand shell environment variables in this setting.

## New laptop

Set up the public dotfiles with Stow first and start a new shell. Install
chezmoi (`brew install chezmoi` on macOS), then authenticate Git to GitHub.
HTTPS authentication can bootstrap access before SSH keys are available.

```sh
chezmoi init https://github.com/marcfranquesa/dotfiles-private.git
chezmoi diff
chezmoi apply
```

Restore private keys separately from an encrypted backup, or register new keys.
Applying the config alone does not grant server access. Keep `~/.ssh` mode 700
and private key files mode 600.

## Daily workflow

```sh
chezmoi edit ~/.ssh/config
chezmoi diff
chezmoi apply
chezmoi cd
git add private_dot_ssh/private_config
git commit -m "fix(ssh): update host configuration"
git push
```

To import an intentional direct edit to the live config, run
`chezmoi add ~/.ssh/config` and review the Git diff. On another laptop, run
`chezmoi git pull`, `chezmoi diff`, and `chezmoi apply`.

Only add specific configuration files. Do not recursively add `~/.ssh`.
Chezmoi's `private_` prefix sets permissions; it does not encrypt contents.

To stop managing SSH config while keeping the live file, run
`chezmoi forget ~/.ssh/config`. Commit and push that change if the file should
also stop being managed on other machines.
