#!/usr/bin/env bash
# Status-bar summary of agent states across all sessions, e.g. "● 2 ○ 3 ✓ 1 ◦ 4 | ".
# Prints nothing when there are no agents. Colors are passed in from tmux.conf
# so they stay in one place.
#
# Usage: agent-summary.sh <blocked-color> <working-color> <done-color> <idle-color> <separator-color>

set -uo pipefail

readonly BLOCKED_COLOR="${1:-red}"
readonly WORKING_COLOR="${2:-yellow}"
readonly DONE_COLOR="${3:-green}"
readonly IDLE_COLOR="${4:-default}"
readonly SEP_COLOR="${5:-default}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

counts="$("$script_dir/agent-list.sh" | awk -F '\t' '
    $2 == "blocked" { b++ }
    $2 == "working" { w++ }
    $2 == "done"    { d++ }
    $2 == "idle"    { i++ }
    END { printf "%d %d %d %d", b, w, d, i }
')"
read -r blocked working done_count idle <<< "$counts"

out=""
if (( blocked > 0 )); then
    out+="#[fg=${BLOCKED_COLOR}]● ${blocked} "
fi
if (( working > 0 )); then
    out+="#[fg=${WORKING_COLOR}]○ ${working} "
fi
if (( done_count > 0 )); then
    out+="#[fg=${DONE_COLOR}]✓ ${done_count} "
fi
if (( idle > 0 )); then
    out+="#[fg=${IDLE_COLOR}]◦ ${idle} "
fi
if [[ -n $out ]]; then
    printf '%s#[fg=%s]| ' "$out" "$SEP_COLOR"
fi
