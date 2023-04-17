_exists() {
    command -v $1 > /dev/null 2>&1
}

alias clc='clear'
alias qq='~ && clear'
alias rg='rg --smart-case'

alias ez='nvim ~/.zshrc'
alias rld='source ~/.zshrc'

alias dfs='cd ~/.dotfiles'
alias ev='nvim ~/.dotfiles/nvim/init.vim'

alias gcob='git branch | fzf | xargs git checkout'

case "$OSTYPE" in
    darwin*)
        alias wk='cd ~/Workspace'
        alias kbs='cd ~/Workspace/keebs'

        alias bkup-brew='brew bundle dump --file=~/.dotfiles/Brewfile --force'
        alias bkpbr=bkup-brew
        alias bkpdw='bkup-dreamworks'
        alias bkpnts='bkup-notes'
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

