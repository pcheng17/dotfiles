#!/usr/bin/env bash
# Status-bar summary of agent states across all sessions, e.g. "● 2 ✓ 1 | ".
# Prints nothing when no agent is blocked or done. Colors are passed in from
# tmux.conf so they stay in one place.
#
# Usage: agent-summary.sh <blocked-color> <done-color> <separator-color>

set -uo pipefail

readonly BLOCKED_COLOR="${1:-red}"
readonly DONE_COLOR="${2:-green}"
readonly SEP_COLOR="${3:-default}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

counts="$("$script_dir/agent-list.sh" | awk -F '\t' '
    $2 == "blocked" { b++ }
    $2 == "done"    { d++ }
    END { printf "%d %d", b, d }
')"
read -r blocked done_count <<< "$counts"

out=""
if (( blocked > 0 )); then
    out+="#[fg=${BLOCKED_COLOR}]● ${blocked} "
fi
if (( done_count > 0 )); then
    out+="#[fg=${DONE_COLOR}]✓ ${done_count} "
fi
if [[ -n $out ]]; then
    printf '%s#[fg=%s]| ' "$out" "$SEP_COLOR"
fi
