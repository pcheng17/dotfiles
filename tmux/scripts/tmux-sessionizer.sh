#!/usr/bin/env bash
#
# Usage: tmux-sessionizer.sh [dir]   pick a directory (fzf) or use dir, then switch to its session
#        tmux-sessionizer.sh --list  print the candidate rows (path<TAB>branch) and exit
#        tmux-sessionizer.sh --sessions
#                                    print name<TAB>path<TAB>alive|dead per session and exit
#
# A session is identified by its start directory and labelled after the branch checked out
# there, so a worktree slot (<repo>-wt-NN) shows up as <repo>/<branch>. Set TMUX_SOCKET_NAME to
# run every tmux command against `tmux -L <name>` instead of the default server.

tmux() {
    command tmux ${TMUX_SOCKET_NAME:+-L "$TMUX_SOCKET_NAME"} "$@"
}

switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "=$1"
    else
        tmux switch-client -t "=$1"
    fi
}

has_session() {
    tmux has-session -t "=$1" 2> /dev/null  # = forces exact match
}

hydrate() {
    if [ -f "$2/.tmux-sessionizer" ]; then
        tmux send-keys -t "$1" "source $2/.tmux-sessionizer" Enter
    elif [ -f "$HOME/.tmux-sessionizer" ]; then
        tmux send-keys -t "$1" "source $HOME/.tmux-sessionizer" Enter
    fi
}

# Prints the branch checked out in $1: (free) for a detached HEAD, nothing outside git.
branch_of() {
    [[ -e $1/.git ]] || return 0
    git -C "$1" symbolic-ref --short -q HEAD || echo '(free)'
}

candidate_rows() {
    local dir
    {
        $FD --max-depth 1 --type d . \
            "$HOME/dev" \
            "$HOME/Workspace" \
            "$HOME/work" \
            "$HOME/git" \
            "$HOME/git/roblox" \
            "$HOME/git/roblox/game-engine" \
            "$HOME/git/roblox/game-engine/master/.claude/worktrees" \
            2>/dev/null
        printf '%s\n' "$HOME/.dotfiles" "$HOME/.dotclaude" "$HOME/.ssh"
    } | while IFS= read -r dir; do
        dir=${dir%/}
        printf '%s\t%s\n' "$dir" "$(branch_of "$dir")"
    done
}

# Prints the session label for directory $1: <repo>/<branch> for a linked worktree on a branch,
# the basename otherwise. tmux forbids . and : in session names.
label_for() {
    local label branch primary
    label=$(basename "$1")
    if [[ -f $1/.git || $label =~ -wt-[0-9]+$ ]]; then
        branch=$(git -C "$1" symbolic-ref --short -q HEAD)
        primary=$(git -C "$1" worktree list --porcelain 2>/dev/null | head -1)
        if [[ -n $branch && $primary == "worktree "* ]]; then
            label="$(basename "${primary#worktree }")/$branch"
        fi
    fi
    printf '%s\n' "$label" | tr .: __
}

# Prints $1, suffixed -2, -3, ... until no session other than $2 has that name.
unique_label() {
    local candidate=$1 n=1
    while [[ $candidate != "$2" ]] && has_session "$candidate"; do
        n=$((n + 1))
        candidate="$1-$n"
    done
    printf '%s\n' "$candidate"
}

sessions() {
    tmux list-sessions -F $'#{session_name}\t#{session_path}\t#{session_attached}' 2>/dev/null
}

# Prints the name of the first session whose start directory resolves to $1.
session_for_dir() {
    local name path _
    while IFS=$'\t' read -r name path _; do
        if [[ $(realpath "$path" 2>/dev/null) == "$1" ]]; then
            printf '%s\n' "$name"
            return
        fi
    done < <(sessions)
}

# Kills every session whose start directory is gone, unless a client is attached to it.
kill_dead_sessions() {
    local name path attached
    while IFS=$'\t' read -r name path attached; do
        if [[ ! -d $path && $attached == 0 ]]; then
            tmux kill-session -t "=$name"
        fi
    done < <(sessions)
}

print_sessions() {
    local name path _
    while IFS=$'\t' read -r name path _; do
        if [[ -d $path ]]; then
            printf '%s\t%s\talive\n' "$name" "$path"
        else
            printf '%s\t%s\tdead\n' "$name" "$path"
        fi
    done < <(sessions)
}

if command -v fd &>/dev/null; then
    FD=fd
elif command -v fdfind &>/dev/null; then
    FD=fdfind
else
    echo "tmux-sessionizer: fd/fdfind not found" >&2
    exit 1
fi

case $1 in
    -l|--list)
        candidate_rows
        exit 0
        ;;
    --sessions)
        print_sessions
        exit 0
        ;;
esac

kill_dead_sessions

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(candidate_rows | fzf --border --print-query --delimiter '\t' --with-nth '{1}  {2}')
    selected=$(echo "$selected" | tail -1 | cut -f1)
fi

if [[ -z $selected ]]; then
    exit 0
fi

if [[ ! -d $selected ]]; then
    # Check if the input is a GitHub URL
    if [[ $selected == https://github.com/* || $selected == git@github.com:* || $selected == *git@codeberg.org* ]]; then
        # It's a GitHub URL, extract the repo name from the URL
        repo_name=$(basename "$selected" .git)
        echo "Cloning GitHub repo '$repo_name' to '${DEV_DIR}/$repo_name'."
        read -r -p "Enter new directory name or press enter to use '$repo_name': " custom_name

        if [[ -n $custom_name ]]; then
            target_dir="${DEV_DIR}/$custom_name"
        else
            target_dir="${DEV_DIR}/$repo_name"
        fi

        if git clone "$selected" "$target_dir"; then
            echo "Repository cloned successfully to $target_dir"
            selected="$target_dir"
        else
            echo "Failed to clone repository"
            exit 1
        fi
    else
        # It's a directory path, offer to create it
        read -p "Directory '${DEV_DIR}/$selected' doesn't exist. Create it? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "${DEV_DIR}/$selected"
            selected="${DEV_DIR}/$selected"
        else
            # User declined to create directory - start session with that name in home dir
            selected_name=$(basename "$selected" | tr .: __)
            selected="$HOME"
        fi
    fi
fi

# Find the session by directory and relabel it if the branch changed. The declined-create
# branch above already named its session, which is looked up by that name as before.
if [[ -z $selected_name ]]; then
    selected=$(realpath "$selected")
    existing=$(session_for_dir "$selected")
    selected_name=$(unique_label "$(label_for "$selected")" "$existing")
    if [[ -n $existing && $existing != "$selected_name" ]]; then
        tmux rename-session -t "=$existing" "$selected_name"
    fi
fi

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    hydrate "$selected_name" "$selected"
    exit 0
fi

if ! has_session "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    hydrate "$selected_name" "$selected"
fi

switch_to "$selected_name"
exit 0
