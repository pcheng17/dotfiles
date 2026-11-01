#!/usr/bin/env bash
# Called from Claude Code hooks (see tmux/claude-hooks.json) to tag the tmux
# pane the agent runs in with @agent_state, which tmux.conf renders in the
# status bar and agent-jump.sh / agent-picker.sh read.
#
# Usage: agent-state.sh <action>
#   idle | working | blocked | done   set that state
#   tool          PreToolUse: blocked for tools that wait on the user
#                 (AskUserQuestion, ExitPlanMode), working otherwise
#   tool-failure  PostToolUseFailure: idle if the user interrupted the tool
#                 with Esc (no Stop follows), working otherwise
#   idle-if-busy  Notification idle_prompt: Claude is waiting for input but
#                 still tagged working/blocked, i.e. the turn was interrupted
#                 with Esc (Stop does not fire on interrupts)
#   clear         remove the tag
#
# Always exits 0 on tmux errors so a hook failure never shows up in Claude.

set -uo pipefail

readonly USER_WAIT_TOOLS_RE='^(AskUserQuestion|ExitPlanMode)$'

action="${1:-}"

# Module not enabled on this host (tmux/agent-status.conf sets AGENT_STATUS),
# or not running inside tmux: nothing to do.
[[ -n ${AGENT_STATUS:-} && -n ${TMUX_PANE:-} ]] || exit 0
command -v tmux &>/dev/null || exit 0

pane_opt() {
    tmux display-message -p -t "$TMUX_PANE" "$1" 2>/dev/null
}

set_state() {
    tmux set-option -p -t "$TMUX_PANE" @agent_state "$1" 2>/dev/null || true
}

# The hook JSON arrives on stdin; print one top-level string/boolean field.
read_json_field() {
    local field="$1" input
    input="$(cat)"
    if command -v jq &>/dev/null; then
        jq -r --arg f "$field" '.[$f] // empty' <<< "$input" 2>/dev/null
    else
        sed -nE "s/.*\"${field}\"[[:space:]]*:[[:space:]]*\"?([^\",}]*)\"?.*/\\1/p" <<< "$input" | head -n 1
    fi
}

# True when someone is looking at this pane right now: it is the active pane
# of the active window, and a focused client is attached to its session.
pane_is_watched() {
    local visible session
    visible="$(pane_opt '#{&&:#{pane_active},#{window_active}}')"
    [[ $visible == 1 ]] || return 1
    session="$(pane_opt '#{session_name}')"
    tmux list-clients -F '#{client_session}	#{client_flags}' 2>/dev/null |
        awk -F '\t' -v s="$session" '$1 == s && $2 ~ /(^|,)focused(,|$)/ { found = 1 } END { exit !found }'
}

case "$action" in
    idle | working | blocked)
        set_state "$action"
        ;;
    done)
        # "done" means "finished, not looked at yet"; skip it if you are watching.
        if pane_is_watched; then
            set_state idle
        else
            set_state done
        fi
        ;;
    tool)
        if [[ "$(read_json_field tool_name)" =~ $USER_WAIT_TOOLS_RE ]]; then
            set_state blocked
        else
            set_state working
        fi
        ;;
    tool-failure)
        if [[ "$(read_json_field is_interrupt)" == true ]]; then
            set_state idle
        else
            set_state working
        fi
        ;;
    idle-if-busy)
        case "$(pane_opt '#{@agent_state}')" in
            working | blocked) set_state idle ;;
        esac
        ;;
    clear)
        tmux set-option -p -u -t "$TMUX_PANE" @agent_state 2>/dev/null || true
        ;;
    *)
        echo "agent-state.sh: unknown action '$action'" >&2
        exit 1
        ;;
esac

exit 0
