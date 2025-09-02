current_hostname=$(hostname)

_exists() {
    command -v $1 > /dev/null 2>&1
}

alias l='ls -lhF'
alias ll='ls -lhF'
alias la='ls -AlhF'
alias c='clear'
alias qq='~ && clear'
alias rg='rg --smart-case'
alias nf='neofetch'

alias ez='nvim ~/.zshrc'
alias rld='source ~/.zshrc'

alias dfs='cd ~/.dotfiles'
alias edfs='nvim ~/.dotfiles'
alias y='yazi'

alias gi='git init'
alias gs='git status --short'
alias ga='git add'
alias gc='git commit'

alias gcob='git branch | fzf --height=50% | xargs git checkout'
alias gbd='git branch | fzf -m | xargs git branch -D'

alias lg='lazygit'
alias v='nvim'
alias j='just'
alias ts='tmux-sessionizer'
alias love='/Applications/love.app/Contents/MacOS/love'

alias tsu='sudo tailscale up'
alias tsd='sudo tailscale down'

alias pdf='./bin/open-pdf'

alias houdaemon='sudo launchctl load -w /Library/LaunchDaemons/com.sidefx.sesinetd.plist'
alias pandock='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/extra'

case "$hostname" in
    darwin*)
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

