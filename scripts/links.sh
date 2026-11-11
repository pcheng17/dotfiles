#!/usr/bin/env bash

source "${DOTFILES_DIR}/helper/defaults.sh"
source "${DOTFILES_DIR}/helper/git.sh"
source "${DOTFILES_DIR}/helper/log.sh"
source "${DOTFILES_DIR}/helper/symlink.sh"

print_section() {
    printf "\033[95m➤ %s\033[0m\n" "$1"
}

setup_personal_symlinks() {
    log_info "Symlinking personal configs..."
    symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
    symlink "$DOTFILES_DIR/bin" "$HOME/bin"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        symlink "$DOTFILES_DIR/Brewfile" "$HOME/Brewfile"
        symlink "$DOTFILES_DIR/aerospace/aerospace.toml" "$HOME/.aerospace.toml"
    fi
}

setup_work_symlinks() {
    log_info "Symlinking work configs..."
    if [[ ! -d "$DOTFILES_DIR/private" ]] || [[ -z "$(ls -A "$DOTFILES_DIR/private" 2>/dev/null | grep -v '^\.keep$')" ]]; then
        log_error "private/ directory is empty -- work mode requires work-specific configs."
        exit 1
    fi
    symlink "$DOTFILES_DIR/private/.zshrc" "$HOME/.zshrc"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        symlink "$DOTFILES_DIR/private/Brewfile" "$HOME/Brewfile"
        symlink "$DOTFILES_DIR/aerospace/aerospace-work.toml" "$HOME/.aerospace.toml"
    fi
}

setup_common() {
    log_info "Symlinking common configs..."
    symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
    symlink "$DOTFILES_DIR/lazygit" "$HOME/.config/lazygit"
    symlink "$DOTFILES_DIR/herdr-app/keys.json" "$HOME/.config/herdr-app/keys.json"
    symlink "$DOTFILES_DIR/herdr-app/settings.json" "$HOME/.config/herdr-app/settings.json"
    symlink "$DOTFILES_DIR/herdr-app/themes/catppuccin-mocha.json" "$HOME/.config/herdr-app/themes/catppuccin-mocha.json"
    symlink "$DOTFILES_DIR/herdr-app/themes/catppuccin-latte.json" "$HOME/.config/herdr-app/themes/catppuccin-latte.json"
    symlink "$DOTFILES_DIR/herdr-app/mods/leader" "$HOME/.config/herdr-app/mods/leader"
    symlink "$DOTFILES_DIR/herdr/config.toml" "$HOME/.config/herdr/config.toml"
    symlink "$DOTFILES_DIR/zsh/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
    symlink "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
    # ~/.config/ghostty used to be a symlink to the whole directory; it's now a real dir holding a per-OS config symlink
    [[ -L "$HOME/.config/ghostty" ]] && unlink "$HOME/.config/ghostty"
    symlink "$DOTFILES_DIR/tuicr" "$HOME/.config/tuicr"

    log_info "Setting git configs..."
    git_set_global core.editor nvim
    git_set_global init.defaultBranch main
    git_set_global include.path "$HOME/.dotfiles/git/aliases"
    git_set_global core.excludesFile "$HOME/.dotfiles/git/gitignore"
    git_set_global pull.rebase false
    git_set_global merge.commit no
    git_set_global rebase.updaterefs true

    case "$OSTYPE" in
        darwin*)
            log_info "Symlinking macOS-specific configs..."
            symlink "$DOTFILES_DIR/macos/DefaultKeyBinding.dict" "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"
            symlink "$DOTFILES_DIR/gh/config.yml" "$HOME/.config/gh/config.yml"
            symlink "$DOTFILES_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
            symlink "$DOTFILES_DIR/zsh/p10k.zsh" "$HOME/.p10k.zsh"
            symlink "$DOTFILES_DIR/ghostty/config-mac" "$HOME/.config/ghostty/config"

            # https://apple.stackexchange.com/questions/332769/macos-disable-popup-showing-accented-characters-when-holding-down-a-key
            defaults write -g ApplePressAndHoldEnabled -bool false
            defaults_enable com.apple.finder AppleShowAllFiles  # Show hidden files in Finder
            defaults_enable com.apple.dock autohide             # Autohide dock
            defaults_set_int NSGlobalDomain KeyRepeat 1         # Set blazingly fast key repeat rate
            defaults_set_int NSGlobalDomain InitialKeyRepeat 10 # Set blazingly fast initial key repeat rate. Default is 15
            defaults_set_int com.apple.finder ShowRecentTags 0  # Disable tags in sidebar
            ;;
        linux*)
            log_info "Symlinking Linux-specific configs..."
            if [[ "${IS_ARCH:-false}" == "true" ]]; then
                symlink "$DOTFILES_DIR/niri" "$HOME/.config/niri"
                symlink "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"
                symlink "$DOTFILES_DIR/ghostty/config-linux" "$HOME/.config/ghostty/config"
                symlink "$DOTFILES_DIR/noctalia" "$HOME/.config/noctalia"
            else
                symlink "$DOTFILES_DIR/xprofile" "$HOME/.xprofile"
            fi
            ;;
        *)
            printf "Unsupported OS: $OSTYPE"
            exit 1
            ;;
    esac
}

case "$MODE" in
    home)
        setup_personal_symlinks
        setup_common
        ;;
    work)
        setup_work_symlinks
        setup_common
        ;;
    *)
        printf "Usage: MODE=home|work ./scripts/links.sh"
        exit 1
        ;;
esac
