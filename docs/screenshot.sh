#!/usr/bin/env zsh

SESSION_NAME=dotfiles-docs
CURRENT_SESSION_NAME=$(tmux display-message -p '#S')

tmux-sessionizer "${SESSION_NAME}"
tmux split-window -h -t "${SESSION_NAME}":1

tmux send-keys -t "${SESSION_NAME}:1.1" 'nvim ~/dotfiles/.config/nvim/lua/config/lazy.lua' C-m
tmux send-keys -t "${SESSION_NAME}:1.2" 'git status' C-m

sleep 0.5
screencapture ~/dotfiles/docs/image.png

tmux-sessionizer "${CURRENT_SESSION_NAME}"
tmux kill-session -t "${SESSION_NAME}"
