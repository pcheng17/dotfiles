_exists() {
    command -v $1 > /dev/null 2>&1
}

alias clr='clear'
alias qq='~ && clear'
alias rg='rg --smart-case'

alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias rld='source ~/.zshrc'

alias dfs='cd ~/.dotfiles'
alias ev='nvim ~/.dotfiles/nvim/init.vim'

alias gcob='git branch | fzf | xargs git checkout'

case "$OSTYPE" in
    darwin*)
        alias ws='cd ~/Workspace'
        alias kbs='cd ~/Workspace/keebs'

        alias bkupbrew='brew bundle dump --file=~/.dotfiles/Brewfile --force'
    ;;
    linux*)
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

