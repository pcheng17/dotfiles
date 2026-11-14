#!/usr/bin/env bash
# fzf session switcher, run inside display-popup.
set -euo pipefail

list=$(tmux list-sessions -F '#{session_name}  (#{session_windows} windows)#{?session_attached, *,}')

target=$(fzf --no-sort <<<"$list" | awk '{print $1}') || exit 0

[ -n "$target" ] && tmux switch-client -t "$target"
