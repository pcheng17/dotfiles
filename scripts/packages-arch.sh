#!/usr/bin/env bash

source "${DOTFILES_DIR}/helper/log.sh"

PACMAN_PACKAGES=(
    "autoconf"
    "base-devel"
    "bison"
    "blender"
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

source "${DOTFILES_DIR}/helper/zsh-bootstrap.sh"
bootstrap_zsh_plugins

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
