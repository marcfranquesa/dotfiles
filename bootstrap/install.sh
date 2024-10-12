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

[ -x "$(command -v stow)" ] && stow . && exit 0

echo "stow is not present" && exit 1
