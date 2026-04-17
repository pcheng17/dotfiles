# Dotfiles

Personal dotfiles for macOS and Linux (Ubuntu). Managed via symlinks, not a symlink manager.

## Repository Structure

```
setup              # Main entry point: ./setup [home|work]
scripts/           # Modular install scripts (packages-macos.sh, packages-linux.sh, links.sh)
helper/            # Bash utilities for symlinks, defaults, printing
install            # Deprecated — delegates to ./setup home --packages-only
configure          # Deprecated — delegates to ./setup [home|work] --links-only
zsh/               # Shell config (zshrc, aliases, p10k, per-host files)
tmux/              # tmux config and scripts
nvim/              # LazyVim-based neovim config
nvim-0.12/         # Separate nvim config for 0.12
wezterm/           # Wezterm terminal config
bin/               # Personal scripts (symlinked to ~/bin)
aerospace/         # AeroSpace window manager (macOS)
karabiner/         # Karabiner-Elements (macOS)
git/               # Git aliases and global gitignore
macos/             # macOS-specific settings (DefaultKeyBinding.dict)
i3/, polybar/, rofi/ # Linux window manager / bar / launcher
private/           # Gitignored work-specific overrides
```

## Setup Flow

```
./setup home    # or: ./setup work
```

Detects OS automatically, installs packages, and applies symlinks in one step.

Options:
- `--packages-only` — only install/update packages (skip symlinks)
- `--links-only` — only apply symlinks and git config (skip packages)

`setup` has two modes:
- **home**: personal zshrc, personal Brewfile, aerospace.toml
- **work**: work-specific configs from `private/` (must be populated first)
- Both share: tmux, nvim, lazygit, wezterm, aliases, git config, OS-specific settings

## Conventions

- Files in the repo are **not** dot-prefixed (e.g., `zsh/zshrc`, `tmux/tmux.conf`). The symlinks in `$HOME` are dot-prefixed (e.g., `~/.zshrc`).
- Per-host zsh config lives in `zsh/<hostname>.zsh`, sourced by hostname in `zshrc`.
- `private/` is gitignored and holds work-specific overrides.
- `bin/secrets/` is gitignored.

## Key Tools

- **Shell**: zsh + oh-my-zsh + powerlevel10k
- **Editor**: neovim (LazyVim)
- **Terminal**: WezTerm
- **Multiplexer**: tmux (with custom sessionizer)
- **Git UI**: lazygit
- **Window manager**: AeroSpace (macOS), i3 (Linux)

## Commit Style

Most commits are short imperative sentences (e.g., "Add keymap", "Update aliases", "Fix autocmd"). Conventional commits (`feat:`, `fix:`) are used occasionally but not required.
