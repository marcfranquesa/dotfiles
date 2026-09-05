#!/bin/sh

set -eu

if [ "$(uname -s)" != "Darwin" ]; then
    echo "macOS settings skipped: this is not macOS."
    exit 0
fi

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Caps Lock -> Escape for saved keyboard entries; replaces each entry's mappings.
# Recheck identifiers on a new Mac, especially alt_handler_id-49.
for keyboard in \
    0-0-0 \
    1133-45921-0 \
    1133-50475-0 \
    13364-1569-0 \
    16700-8464-0 \
    16700-8467-0 \
    alt_handler_id-49
do
    defaults -currentHost write NSGlobalDomain \
        "com.apple.keyboard.modifiermapping.$keyboard" -array \
        '<dict><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer><key>HIDKeyboardModifierMappingDst</key><integer>30064771113</integer></dict>'
done

# Trackpad
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1

# Mouse
defaults write NSGlobalDomain com.apple.mouse.scaling -float 3

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true

echo "Applied macOS settings. Log out and back in if changes are not visible."
