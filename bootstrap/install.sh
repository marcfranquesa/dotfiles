#!/bin/sh

shell=$(basename "$SHELL")
profile_path=".config/shell/profile"

case "$shell" in
    bash)
        ln -sf $profile_path .bash_profile
        ;;
    zsh)
        ln -sf $profile_path .zprofile
        ;;
    *)
        echo "Shell $shell is not supported."
        ;;
esac

command -v stow > /dev/null && stow . && exit 0

echo "stow is not present" && exit 1
