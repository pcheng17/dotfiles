#!/usr/bin/env bash

source "${DOTFILES_DIR}/helper/log.sh"

# Installs oh-my-zsh, the powerlevel10k theme, the zsh-autosuggestions
# plugin, and the tmux plugin manager (tpm), skipping anything already
# present. Shared by scripts/packages-linux.sh, scripts/packages-arch.sh,
# and scripts/packages-macos.sh.
bootstrap_zsh_plugins() {
    # oh-my-zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log_info "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        log_ok "oh-my-zsh is already installed, skipping"
    fi

    P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [ ! -d "$P10K_DIR" ]; then
        log_info "Installing powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    else
        log_ok "powerlevel10k is already installed, skipping"
    fi

    AUTOSUGGEST_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    if [ ! -d "$AUTOSUGGEST_DIR" ]; then
        log_info "Installing zsh-autosuggestions plugin..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    else
        log_ok "zsh-autosuggestions is already installed, skipping"
    fi

    # Install tmux plugin manager
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        log_info "Installing tmux plugin manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        log_ok "tmux plugin manager already installed."
    fi
}
