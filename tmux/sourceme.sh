ts() {
    "$DOTS"/tmux/scripts/tmux-sessionizer.sh "$@"
}

ta() {
    tmux attach "$@"
}

tks() {
    "$DOTS"/tmux/scripts/tmux-kill-session.sh "$@"
}
