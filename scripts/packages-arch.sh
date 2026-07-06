#!/usr/bin/env bash

source "${DOTFILES_DIR}/helper/log.sh"

PACMAN_PACKAGES=(
    "curl"
    "ffmpeg"                                          # CLI video processing
    "libnotify"                                       # CLI system notifications
    "mpv"                                             # CLI media player
    "fastfetch"                                       # CLI system information
    "just"                                            # CLI command runner
    "ripgrep"                                         # CLI better grep
    "fd"                                              # CLI better find
    "unzip"
    "wget"
    "btop"                                            # System monitor
    "wl-clipboard"                                    # Clipboard (Wayland)
    "ethtool"                                         # Network tools
    "duf"                                             # Disk usage
    "love"
    "solaar"                                          # Logitech device manager
    "flatpak"
    "zsh"
    "base-devel"
    "libtool"
    "autoconf"
    "clang"                                           # Includes clang-format
    "glfw-x11"                                        # C++ graphics
    "xz"
    "tk"
    "sqlite"
    "bzip2"
    "readline"
    "openssl"
    "libevent"
    "ncurses"
    "pkgconf"
    "bison"
    "cmake"
    "ninja"
    "neovim"
    "tmux"
    "lazygit"
    "fzf"
    "tailscale"
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
# 1Password: AUR-only (no AUR helper set up) -- install manually if needed
# Brave Browser: AUR-only (no AUR helper set up) -- install manually if needed
# Wezterm: historically AUR-only -- check `pacman -Si wezterm` first, may have landed in extra/community
# Steam: requires the multilib repo enabled in /etc/pacman.conf, then `pacman -S steam`
# NVIDIA driver: `nvidia` or `nvidia-open` depending on GPU -- check CachyOS docs for the recommended package
# Flatpak apps: OBS, Spotify, Discord, Flatseal -- add Flathub remote, then install via flatpak
