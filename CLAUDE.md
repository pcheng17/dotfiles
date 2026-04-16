# Dotfiles

Personal dotfiles for macOS and Linux (Ubuntu). Managed via symlinks, not a symlink manager.

## Repository Structure

```
configure          # Main entry point: ./configure [home|work]
install            # Bootstrap script (Homebrew, oh-my-zsh)
setup              # Linux (apt) package installation
helper/            # Bash utilities for symlinks, defaults, printing
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

1. `./install` — bootstrap (Homebrew on macOS, oh-my-zsh)
2. `./setup` — install Linux packages (Ubuntu only)
3. `./configure home` or `./configure work` — create symlinks and set OS defaults

`configure` has two modes:
- **home**: personal zshrc, personal Brewfile, aerospace.toml
- **work**: private zshrc, private Brewfile, aerospace-work.toml
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
