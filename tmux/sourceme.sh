ts() {
    "$DOTS"/tmux/scripts/tmux-sessionizer.sh "$@"
}

ta() {
    tmux attach "$@"
}

tks() {
    "$DOTS"/tmux/scripts/tmux-kill-session.sh "$@"
}

# Clear a pane's agent status tag (tmux/scripts/agent-state.sh) whenever the
# shell prompt comes back. A prompt means no agent is in the foreground, which
# also cleans up after an agent that died without firing its SessionEnd hook.
# Only registered where tmux/agent-status.conf is enabled (sets AGENT_STATUS).
if [[ -n ${ZSH_VERSION:-} && -n ${AGENT_STATUS:-} && -n ${TMUX_PANE:-} ]]; then
    _agent_state_clear() {
        tmux set-option -p -u -t "$TMUX_PANE" @agent_state 2>/dev/null
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _agent_state_clear
fi
