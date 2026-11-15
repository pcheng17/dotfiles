#!/usr/bin/env bash
# fzf session switcher, run inside display-popup.
set -euo pipefail

list=$(tmux list-sessions -F $'#{session_attached}\t#{session_name}' \
      | sort -t$'\t' -k1,1nr -s | cut -f2-)

target=$(fzf --border --no-sort <<<"$list" | awk '{print $1}') || exit 0

[ -n "$target" ] && tmux switch-client -t "$target"
