current_hostname=$(hostname)

_exists() {
    command -v $1 > /dev/null 2>&1
}

alias l='ls -lhF'
alias ll='ls -lhF'
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
alias gupb='CBRANCH=$(git branch --show-current); git fetch origin $CBRANCH && g merge origin/$CBRANCH'
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

alias pdf='./bin/open-pdf'

alias houdaemon='sudo launchctl load -w /Library/LaunchDaemons/com.sidefx.sesinetd.plist'
alias pandock='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/extra'

case "$hostname" in
    darwin*)
        alias love='/Applications/love.app/Contents/MacOS/love'
    ;;
    home)
    ;;
esac

# Change this to use `case`
if [[ "$current_hostname" == "HQ-VP606YTPQ2" ]]; then
    # Work machine
    alias wk='cd ~/work'
    alias bkupbrew='TMP="/private/tmp/brewfile_backup_$(date +%s)" && brew bundle dump --file="$TMP" --force && grep -v "^vscode" "$TMP" > ~/.dotfiles/private/Brewfile && rm "$TMP"'
else
    # Personal machines
    alias dv='cd ${DEV_DIR}'
    alias bkupbrew='TMP="/private/tmp/brewfile_backup_$(date +%s)" && brew bundle dump --file="$TMP" --force && grep -v "^vscode" "$TMP" > ~/.dotfiles/Brewfile && rm "$TMP"'
fi

