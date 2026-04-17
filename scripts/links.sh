#!/usr/bin/env bash

source "${DOTFILES_DIR}/helper/defaults.sh"
source "${DOTFILES_DIR}/helper/git.sh"
source "${DOTFILES_DIR}/helper/symlink.sh"

setup_personal_symlinks() {
    echo "Setting up personal symlinks"
    echo "==========================================="
    symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
    symlink "$DOTFILES_DIR/bin" "$HOME/bin"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        symlink "$DOTFILES_DIR/Brewfile" "$HOME/Brewfile"
        symlink "$DOTFILES_DIR/aerospace/aerospace.toml" "$HOME/.aerospace.toml"
    fi
}

setup_work_symlinks() {
    echo "Setting up work symlinks"
    echo "==========================================="
    if [[ ! -d "$DOTFILES_DIR/private" ]] || [[ -z "$(ls -A "$DOTFILES_DIR/private" 2>/dev/null | grep -v '^\.keep$')" ]]; then
        printf "\033[31m[ERROR]\033[0m private/ directory is empty -- work mode requires work-specific configs.\n"
        exit 1
    fi
    symlink "$DOTFILES_DIR/private/.zshrc" "$HOME/.zshrc"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        symlink "$DOTFILES_DIR/private/Brewfile" "$HOME/Brewfile"
        symlink "$DOTFILES_DIR/aerospace/aerospace-work.toml" "$HOME/.aerospace.toml"
    fi
}

setup_common() {
    echo "Setting up common symlinks"
    echo "==========================================="
    symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
    symlink "$DOTFILES_DIR/lazygit" "$HOME/.config/lazygit"
    symlink "$DOTFILES_DIR/zsh/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
    symlink "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"

    echo ""
    echo "Global git settings"
    echo "==========================================="
    git_set_global core.editor nvim
    git_set_global init.defaultBranch main
    git_set_global include.path "$HOME/.dotfiles/git/aliases"
    git_set_global core.excludesFile "$HOME/.dotfiles/git/gitignore"
    git_set_global pull.rebase false
    git_set_global merge.commit no
    git_set_global rebase.updaterefs true

    case "$OSTYPE" in
        darwin*)
            echo ""
            echo "Mac settings"
            echo "==========================================="
            symlink "$DOTFILES_DIR/macos/DefaultKeyBinding.dict" "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"
            symlink "$DOTFILES_DIR/gh/config.yml" "$HOME/.config/gh/config.yml"
            symlink "$DOTFILES_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
            symlink "$DOTFILES_DIR/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"
            symlink "$DOTFILES_DIR/zsh/p10k.zsh" "$HOME/.p10k.zsh"

            # https://apple.stackexchange.com/questions/332769/macos-disable-popup-showing-accented-characters-when-holding-down-a-key
            defaults write -g ApplePressAndHoldEnabled -bool false
            defaults_enable com.apple.finder AppleShowAllFiles  # Show hidden files in Finder
            defaults_enable com.apple.dock autohide             # Autohide dock
            defaults_set_int NSGlobalDomain KeyRepeat 1         # Set blazingly fast key repeat rate
            defaults_set_int NSGlobalDomain InitialKeyRepeat 10 # Set blazingly fast initial key repeat rate. Default is 15
            defaults_set_int com.apple.finder ShowRecentTags 0  # Disable tags in sidebar
            ;;
        linux*)
            echo ""
            echo "Linux settings"
            echo "==========================================="
            symlink "$DOTFILES_DIR/polybar" "$HOME/.config/polybar"
            symlink "$DOTFILES_DIR/i3" "$HOME/.config/i3"
            symlink "$DOTFILES_DIR/xprofile" "$HOME/.xprofile"
            ;;
        *)
            echo "Unsupported OS: $OSTYPE"
            exit 1
            ;;
    esac
}

case "$MODE" in
    home)
        setup_personal_symlinks
        echo ""
        setup_common
        ;;
    work)
        setup_work_symlinks
        echo ""
        setup_common
        ;;
    *)
        printf "\033[31m[ERROR]\033[0m Unknown mode: %s\n" "$MODE"
        exit 1
        ;;
esac
