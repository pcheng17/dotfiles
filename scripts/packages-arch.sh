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
    "cuda"
    "curl"
    "duf"                                             # Disk usage
    "ethtool"                                         # Network tools
    "fastfetch"                                       # CLI system information
    "fd"                                              # CLI better find
    "ffmpeg"                                          # CLI video processing
    "flatpak"
    "fzf"
    "ghostty"                                         # Terminal emulator
    "github-cli"                                      # gh
    "glfw-x11"                                        # C++ graphics
    "just"                                            # CLI command runner
    "lazygit"
    "libevent"                                        # tmux build dep (scripts/build-tmux.sh)
    "libnotify"                                       # CLI system notifications
    "libtool"
    "love"
    "mpv"                                             # CLI media player
    "ncurses"                                         # tmux build dep
    "ninja"
    "nodejs"
    "npm"
    "openssl"
    "pkgconf"                                         # tmux build dep
    "proton-vpn-gtk-app"                              # VPN client
    "readline"
    "ripgrep"                                         # CLI better grep
    "solaar"                                          # Logitech device manager
    "sqlite"
    "tailscale"
    "tk"
    "tree-sitter-cli"
    "ttf-jetbrains-mono-nerd"
    "typst"
    "ufw"                                              # Firewall
    "unzip"
    "wget"
    "wl-clipboard"                                    # Clipboard (Wayland)
    "xz"
    "zsh"
)

log_info "Installing pacman packages..."
sudo pacman -Syu --needed "${PACMAN_PACKAGES[@]}"

log_info "Enabling tailscaled..."
sudo systemctl enable --now tailscaled

log_info "Enabling ufw firewall..."
sudo systemctl enable --now ufw
sudo ufw --force enable

# tmux built from source (3.8 has issues with WezTerm)
TMUX_VERSION="3.7c"
if [[ "$("$HOME/.local/bin/tmux" -V 2>/dev/null)" == "tmux ${TMUX_VERSION}" ]]; then
    log_ok "tmux ${TMUX_VERSION} already installed."
else
    log_info "Building tmux ${TMUX_VERSION} from source..."
    "${DOTFILES_DIR}/scripts/build-tmux.sh" "$TMUX_VERSION"
fi

# tuicr (custom build)
if command -v cargo &>/dev/null; then
    log_info "Installing tuicr (tangentspaces fork)..."
    cargo install --git https://github.com/tangentspaces/tuicr --locked --force
else
    log_error "cargo not found, skipping tuicr install"
fi

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
