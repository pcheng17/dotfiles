_exists() {
    command -v $1 > /dev/null 2>&1
}

alias clr='clear'
alias qq='~ && clear'

[ -d ~/.dotfiles ] && alias dfs='cd ~/.dotfiles'

alias doc='cd /mnt/d/Peter/Documents'
alias ws='cd /mnt/d/Peter/Documents/Workspace'
alias lvs='cd /mnt/d/Peter/Documents/Workspace/lindsay-voidspace'
alias vspc='cd /mnt/d/Peter/Documents/Workspace/voidspace'
alias vspcg='cd /mnt/d/Peter/Documents/Workspace/vspc_graph'
alias vdb='cd /usr/local/include/openvdb'
alias kbs='cd /mnt/d/Peter/Documents/Workspace/keebs'

alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'
