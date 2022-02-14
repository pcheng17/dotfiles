_exists() {
    command -v $1 > /dev/null 2>&1
}

alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias rld='source ~/.zshrc'

alias fzf="fzf --height 40%"

alias clr='clear'
alias qq='~ && clear'
alias rg='rg --smart-case'

alias dfs='cd ~/.dotfiles'

alias gcob='git branch | fzf | xargs git checkout'

case "$OSTYPE" in
    darwin*)
        alias ws='cd ~/Workspace'
    ;;
    linux*)
        alias nt='nvim -c VimwikiIndex'

        alias notes='cd /mnt/d/Peter/Documents/Workspace/notes'
        alias doc='cd /mnt/d/Peter/Documents'
        alias dld='cd /mnt/d/Peter/Downloads'
        alias ws='cd /mnt/d/Peter/Documents/Workspace'
        alias lvs='cd /mnt/d/Peter/Documents/Workspace/lindsay-voidspace'
        alias vspc='cd /mnt/d/Peter/Documents/Workspace/voidspace'
        alias vspcg='cd /mnt/d/Peter/Documents/Workspace/vspc_graph'
        alias vdb='cd /usr/local/include/openvdb'
        alias kbs='cd /mnt/d/Peter/Documents/Workspace/keebs'
    ;;
esac

