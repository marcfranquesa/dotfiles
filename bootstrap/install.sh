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

command -v stow > /dev/null && stow . && exit 0

echo "stow is not present" && exit 1
