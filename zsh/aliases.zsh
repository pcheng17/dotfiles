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

alias ez='nvim ~/.zshrc'
alias rld='source ~/.zshrc'

alias dfs='cd ~/.dotfiles'
alias edfs='nvim ~/.dotfiles'

alias gcob='git branch | fzf --height=50% | xargs git checkout'
alias gbd='git branch | fzf -m | xargs git branch -D'

alias lg='lazygit'
alias vim='nvim'
alias v='nvim'
alias t='tmux'
alias j='just'
alias ts='tmux-sessionizer'

alias houdaemon='sudo launchctl load -w /Library/LaunchDaemons/com.sidefx.sesinetd.plist'
alias pandock='docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/extra'

case "$OSTYPE" in
    darwin*)
    ;;
    linux*)
        alias notes='cd /mnt/d/Peter/Documents/Workspace/notes'
        alias doc='cd /mnt/d/Peter/Documents'
        alias dld='cd /mnt/d/Peter/Downloads'
        alias wk='cd /mnt/d/Peter/Documents/Workspace'
        alias lvs='cd /mnt/d/Peter/Documents/Workspace/lindsay-voidspace'
        alias vspc='cd /mnt/d/Peter/Documents/Workspace/voidspace'
        alias vspcg='cd /mnt/d/Peter/Documents/Workspace/vspc_graph'
        alias vdb='cd /usr/local/include/openvdb'
        alias kbs='cd /mnt/d/Peter/Documents/Workspace/keebs'
    ;;
esac

if [[ "$current_hostname" == "HQ-VP606YTPQ2" ]]; then
    # Work machine
    alias wk='cd ~/work'
    alias bkupbrew='TMP="/private/tmp/brewfile_backup_$(date +%s)" && brew bundle dump --file="$TMP" --force && grep -v "^vscode" "$TMP" > ~/.dotfiles/private/Brewfile && rm "$TMP"'
else
    # Personal machines
    alias wk='cd ${WORK_DIR}'
    alias bkupbrew='TMP="/private/tmp/brewfile_backup_$(date +%s)" && brew bundle dump --file="$TMP" --force && grep -v "^vscode" "$TMP" > ~/.dotfiles/Brewfile && rm "$TMP"'
fi

