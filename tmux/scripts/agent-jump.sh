#!/usr/bin/env bash
# Jump to the next agent pane that needs attention, across all sessions.
# Targets blocked panes first, then done ones. Pressing again while already on
# a target cycles to the next pane in the same state.

set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
current_pane="$(tmux display-message -p '#{pane_id}')"

# Panes in the most urgent state present (blocked, else done).
mapfile -t targets < <(
    "$script_dir/agent-list.sh" | awk -F '\t' '
        $2 != "blocked" && $2 != "done" { next }
        top == "" { top = $1 }
        $1 == top { print $3 }
    '
)

if (( ${#targets[@]} == 0 )); then
    tmux display-message "No agents waiting on you"
    exit 0
fi

# Default to the first target; if we are on one, take the one after it.
next="${targets[0]}"
for i in "${!targets[@]}"; do
    if [[ ${targets[$i]} == "$current_pane" ]]; then
        next="${targets[$(( (i + 1) % ${#targets[@]} ))]}"
        break
    fi
done

tmux switch-client -t "$next" \; select-window -t "$next" \; select-pane -t "$next"
