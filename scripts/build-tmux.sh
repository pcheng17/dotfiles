#!/usr/bin/env bash
# Build tmux from a release tarball and install it into ~/.local.
#
# Usage: scripts/build-tmux.sh [version] [prefix]
#   version  tmux release tag (default: 3.7c)
#   prefix   install prefix   (default: $HOME/.local)
#
# Dependencies:
#   macOS:  brew install libevent ncurses pkg-config utf8proc
#   Ubuntu: sudo apt install build-essential libevent-dev libncurses-dev pkg-config bison
#   Arch:   sudo pacman -S base-devel libevent ncurses

set -euo pipefail

VERSION="${1:-3.7c}"
PREFIX="${2:-$HOME/.local}"
TARBALL="tmux-${VERSION}.tar.gz"
URL="https://github.com/tmux/tmux/releases/download/${VERSION}/${TARBALL}"

BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT

echo "==> Downloading tmux ${VERSION}"
curl -fL --progress-bar -o "$BUILD_DIR/$TARBALL" "$URL"
tar -xzf "$BUILD_DIR/$TARBALL" -C "$BUILD_DIR"
cd "$BUILD_DIR/tmux-${VERSION}"

CONFIGURE_ARGS=(--prefix="$PREFIX")

case "$(uname -s)" in
    Darwin)
        BREW_PREFIX="$(brew --prefix)"
        export PKG_CONFIG_PATH="$BREW_PREFIX/opt/ncurses/lib/pkgconfig:$BREW_PREFIX/opt/utf8proc/lib/pkgconfig:${PKG_CONFIG_PATH:-}"
        CONFIGURE_ARGS+=(--enable-utf8proc)
        JOBS="$(sysctl -n hw.ncpu)"
        ;;
    *)
        JOBS="$(nproc)"
        ;;
esac

echo "==> Configuring (prefix: $PREFIX)"
./configure "${CONFIGURE_ARGS[@]}"

echo "==> Building with $JOBS jobs"
make -j"$JOBS"

echo "==> Installing"
make install

echo "==> Installed: $("$PREFIX/bin/tmux" -V) at $PREFIX/bin/tmux"
echo "    Restart the server to pick it up: tmux kill-server"
