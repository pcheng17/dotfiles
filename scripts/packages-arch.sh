#!/usr/bin/env bash

source "${DOTFILES_DIR}/helper/log.sh"

PACMAN_PACKAGES=(
    "autoconf"
    "base-devel"
    "bison"
    "bob"                                             # neovim manager
    "btop"                                            # System monitor
    "bzip2"
    "clang"                                           # Includes clang-format
    "cmake"
    "curl"
    "duf"                                             # Disk usage
    "ethtool"                                         # Network tools
    "fastfetch"                                       # CLI system information
    "fd"                                              # CLI better find
    "ffmpeg"                                          # CLI video processing
    "flatpak"
    "fzf"
    "glfw-x11"                                        # C++ graphics
    "just"                                            # CLI command runner
    "lazygit"
    "libevent"
    "libnotify"                                       # CLI system notifications
    "libtool"
    "love"
    "mpv"                                             # CLI media player
    "ncurses"
    "ninja"
    "nodejs"
    "npm"
    "openssl"
    "pkgconf"
    "readline"
    "ripgrep"                                         # CLI better grep
    "solaar"                                          # Logitech device manager
    "sqlite"
    "tailscale"
    "tk"
    "tmux"
    "tree-sitter-cli"
    "ttf-jetbrains-mono-nerd"
    "unzip"
    "wget"
    "wl-clipboard"                                    # Clipboard (Wayland)
    "xz"
    "zsh"
)

log_info "Installing pacman packages..."
sudo pacman -Sy --needed "${PACMAN_PACKAGES[@]}"

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
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
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

# Manual installs (reference):
# Steam: requires the multilib repo enabled in /etc/pacman.conf, then `pacman -S steam`
# NVIDIA driver: `nvidia` or `nvidia-open` depending on GPU -- check CachyOS docs for the recommended package

# Flatpak apps:
#  - 1Password
#  - OBS
#  - Discord
#  - Zen
#  - Spotify
#  - Steam
#  - Blender

# Wezterm seems to be unsupported on CachyOS
