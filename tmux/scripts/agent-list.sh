#!/usr/bin/env bash
# List every tmux pane tagged with @agent_state by agent-state.sh, most
# urgent first. Panes whose foreground process is a plain shell are skipped:
# the agent exited without clearing its tag (crash, kill -9, etc.).
#
# Output (tab-separated): priority  state  pane_id  location  path
#   priority: 1 blocked, 2 done, 3 working, 4 idle

set -uo pipefail

readonly SHELL_RE='^-?(zsh|bash|sh|fish|dash)$'

tmux list-panes -a -F \
    '#{@agent_state}	#{pane_id}	#{session_name}:#{window_index}.#{pane_index}	#{pane_current_command}	#{pane_current_path}' \
    2>/dev/null |
    awk -F '\t' -v shell_re="$SHELL_RE" '
        BEGIN { OFS = "\t"; prio["blocked"] = 1; prio["done"] = 2; prio["working"] = 3; prio["idle"] = 4 }
        $1 == "" || !($1 in prio) { next }
        $4 ~ shell_re { next }
        { print prio[$1], $1, $2, $3, $5 }
    ' |
    sort -t "$(printf '\t')" -k1,1n -k3,3V
