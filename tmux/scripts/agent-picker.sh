#!/usr/bin/env bash
# fzf picker over every agent pane in every session, most urgent first.
# Meant to run inside a tmux display-popup. The preview shows the bottom of
# each pane.

set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v fzf &>/dev/null; then
    echo "agent-picker: fzf not found" >&2
    read -r -n 1 -s -p "Press any key to close"
    exit 1
fi

list="$("$script_dir/agent-list.sh")"
if [[ -z $list ]]; then
    echo "No agent panes found"
    read -r -n 1 -s -p "Press any key to close"
    exit 0
fi

# Display columns: pane_id (hidden), state, location, path.
selected="$(
    printf '%s\n' "$list" |
        awk -F '\t' '
            BEGIN { OFS = "\t"; icon["blocked"] = "●"; icon["done"] = "✓"; icon["working"] = "…"; icon["idle"] = " " }
            { home = ENVIRON["HOME"]; if (home != "" && index($5, home) == 1) $5 = "~" substr($5, length(home) + 1); print $3, icon[$2] " " $2, $4, $5 }
        ' |
        column -t -s "$(printf '\t')" |
        fzf --border --with-nth 2.. --no-sort --reverse \
            --preview 'tmux capture-pane -ep -t {1} | tail -n "$FZF_PREVIEW_LINES"' \
            --preview-window 'down,60%'
)"

[[ -z $selected ]] && exit 0

pane_id="${selected%% *}"
tmux switch-client -t "$pane_id" \; select-window -t "$pane_id" \; select-pane -t "$pane_id"
