#!/bin/sh

plugins_path="$XDG_DATA_HOME/tmux/plugins"
mkdir -p "${plugins_path}"

# catppuccin
plugin_url="git@github.com:catppuccin/tmux.git"
plugin_dir="catppuccin"
git clone "${plugin_url}" "${plugins_path}/${plugin_dir}"
