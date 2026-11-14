#!/usr/bin/env bash

source "${DOTFILES_DIR}/helper/log.sh"

BREW_TAPS=(
    "jesseduffield/lazygit"
    "nikitabobko/tap"
)

BREW_PACKAGES=(
    "bob"     # nvim version manager
    "btop"
    "clang-format"
    "cloc"
    "cmake"
    "cmark"
    "ffmpeg"
    "fzf"
    "fd"
    "gh"
    "jemalloc"  # tmux build dep (scripts/build-tmux.sh)
    "jj"
    "jq"
    "just"
    "lazygit"
    "libevent"  # tmux build dep
    "mole"    # Deep clean and optimize my Mac
    "ncurses"   # tmux build dep
    "pkgconf"   # tmux build dep
    "raylib"
    "restic"
    "ripgrep"
    "tailscale"
    "terminal-notifier"  # used by bin/shl
    "tree"
    "tree-sitter-cli"    # required by nvim treesitter config
    "utf8proc"  # tmux build dep
    "uv"
    "watchexec"
    "yt-dlp"
)

BREW_CASKS=(
    "1password"
    "alfred"
    "alt-tab"
    "brave-browser"
    "font-departure-mono"
    "font-fira-code"
    "font-fira-mono"
    "font-inconsolata"
    "font-iosevka"
    "font-jetbrains-mono"
    "font-jetbrains-mono-nerd-font"
    "font-roboto-mono"
    "font-ubuntu-mono"
    "ghostty"
    "gimp"
    "linear"
    "love"
    "nikitabobko/tap/aerospace"
    "numi"
    "obs"
    "signal"
    "skim"
    "steam"
    "tailscale-app"
    "wezterm"
)

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    log_ok "Homebrew already installed."
fi

# Add taps
for tap in "${BREW_TAPS[@]}"; do
    if brew tap | grep -q "^${tap}$"; then
        log_ok "$tap already tapped."
    else
        log_info "Tapping $tap..."
        brew tap "$tap"
    fi
done

missing_packages=()
for pkg in "${BREW_PACKAGES[@]}"; do
    if brew list --formula "$pkg" &>/dev/null; then
        log_ok "$pkg already installed."
    else
        log_info "Queuing $pkg for installation..."
        missing_packages+=("$pkg")
    fi
done

missing_casks=()
for cask in "${BREW_CASKS[@]}"; do
    if brew list --cask "$cask" &>/dev/null; then
        log_ok "$cask already installed."
    else
        log_info "Queuing $cask for installation..."
        missing_casks+=("$cask")
    fi
done

if [[ ${#missing_packages[@]} -gt 0 ]]; then
    log_info "Installing packages: ${missing_packages[*]}"
    brew install "${missing_packages[@]}"
fi

if [[ ${#missing_casks[@]} -gt 0 ]]; then
    log_info "Installing casks: ${missing_casks[*]}"
    brew install --cask "${missing_casks[@]}"
fi

source "${DOTFILES_DIR}/helper/zsh-bootstrap.sh"
bootstrap_zsh_plugins

# Install Rust/Cargo via rustup
if ! command -v cargo &>/dev/null; then
    log_info "Installing Rust via rustup..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
else
    log_ok "Rust/Cargo already installed."
fi

# tuicr (custom build)
log_info "Installing tuicr (tangentspaces fork)..."
cargo install --git https://github.com/tangentspaces/tuicr --locked --force

# Install nvim via bob
if ! command -v nvim &>/dev/null; then
    log_info "Installing Neovim via bob..."
    bob install latest
    bob use latest
else
    log_ok "Neovim already installed."
fi

# tmux built from source (3.8 has issues with WezTerm)
TMUX_VERSION="3.7c"
if [[ "$("$HOME/.local/bin/tmux" -V 2>/dev/null)" == "tmux ${TMUX_VERSION}" ]]; then
    log_ok "tmux ${TMUX_VERSION} already installed."
else
    log_info "Building tmux ${TMUX_VERSION} from source..."
    "${DOTFILES_DIR}/scripts/build-tmux.sh" "$TMUX_VERSION"
fi
