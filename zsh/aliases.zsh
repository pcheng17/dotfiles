_exists() {
    command -v $1 > /dev/null 2>&1
}

alias l='ls -lhF'
# alias ll='ls -lhF' # l and ll are identical!
alias la='ls -AlhF'
alias qq='~ && clear'
alias rg='rg --smart-case'
alias nf='neofetch'

alias ez='nvim ~/.zshrc'
alias rld='source ~/.zshrc'

alias dot='cd $DOTS'
alias updot='cd $DOTS && git pull && cd -'
alias y='yazi'

alias gi='git init'
alias gs='git status --short'
alias ga='git add'
alias gc='git commit'

alias gwa='git worktree add'
alias gwls='git worktree list'
alias gupb='b=$(git branch --show-current); git fetch origin $b && git merge origin/$b'
alias gcob='git branch | fzf --height=50% | xargs git checkout'
alias gbd='git branch | fzf -m | xargs git branch -D'
alias uncommit='git reset --soft HEAD~1'

alias lg='lazygit'
alias v='nvim'
alias j='just'
alias oc='opencode'
alias c='claude'

alias tsu='sudo tailscale up'
alias tsd='sudo tailscale down'

alias houdaemon='sudo launchctl load -w /Library/LaunchDaemons/com.sidefx.sesinetd.plist'

case "$OSTYPE" in
    darwin*)
        alias love='/Applications/love.app/Contents/MacOS/love'
    ;;
esac

case "$HOST" in
    HQ-VP606YTPQ2)
        alias bkupbrew='TMP="/private/tmp/brewfile_backup_$(date +%s)" && brew bundle dump --file="$TMP" --force && grep -v "^vscode" "$TMP" > ~/.dotfiles/private/Brewfile && rm "$TMP"'
        ;;
    *)
        alias bkupbrew='TMP="/private/tmp/brewfile_backup_$(date +%s)" && brew bundle dump --file="$TMP" --force && grep -v "^vscode" "$TMP" > ~/.dotfiles/Brewfile && rm "$TMP"'
        ;;
esac

gwrm() {
    if ! _exists fzf; then
        git worktree remove "$@"
        return
    fi
    local wt
    wt=$(git worktree list | fzf --prompt="Remove worktree> " | awk '{print $1}')
    [[ -z "$wt" ]] && return 0
    if ! git worktree remove "$wt" 2>/dev/null; then
        read -rq "REPLY?Worktree has changes. Force remove? [y/N] "
        echo
        [[ "$REPLY" =~ ^[Yy]$ ]] && git worktree remove --force "$wt"
    fi
}
