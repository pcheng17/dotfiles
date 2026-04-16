#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(tmux list-sessions -F "#{session_name}" | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

tmux kill-session -t $selected
