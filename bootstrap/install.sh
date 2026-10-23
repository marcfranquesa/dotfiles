#!/bin/sh

shell=$(basename "$SHELL")
profile_path=".config/shell/profile"
env_path=".config/shell/env"

command -v zsh > /dev/null && ln -sf "$env_path" .zshenv

case "$shell" in
    bash)
        ln -sf "$profile_path" .bash_profile
        ;;
    zsh)
        ln -sf "$profile_path" .zprofile
        ;;
    sh)
        ln -sf "$profile_path" .profile
        ;;
    *)
        echo "Shell $shell is not supported."
        ;;
esac

if command -v stow > /dev/null; then
    # Keep this parent unfolded so Stow applies the skill-source ignore.
    mkdir -p ../.config/agents || exit 1
    exec stow .
fi

echo "stow is not present" && exit 1
