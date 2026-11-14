# tmux

`tmux.conf` is symlinked to `~/.tmux.conf` by `scripts/links.sh`.

## Per-host settings

`tmux.conf` sources `hosts/<host_short>.conf` if it exists (skipped silently
otherwise). Find a machine's name with:

```sh
tmux display -p '#{host_short}'
```

## Agent status module

`agent-status.conf` shows the state of Claude Code agents running in tmux
panes:

| Where | What |
|---|---|
| Next to window names | Red `●` blocked, green `✓` done (not looked at yet), peach `…` working |
| Start of status-right | Count of blocked/working/done/idle agents across all sessions, e.g. `● 2 ○ 3 ✓ 1 ◦ 4 \|` |
| `prefix + a` | Jump to the next blocked (else done) agent in any session; repeat to cycle |
| `prefix + A` | fzf picker over every agent pane, with a preview |

It is opt-in per machine and off by default.

### Enabling it on a machine

1. Create `hosts/<host_short>.conf` (see above) containing:

   ```tmux
   source-file "$HOME/.dotfiles/tmux/agent-status.conf"
   ```

2. Merge `claude-hooks.json` into `~/.claude/settings.json`, then restart
   running Claude sessions. The hooks block can be the same on every machine:
   it does nothing where the module is off.

3. Reload tmux (`prefix + r`) and open new panes. The module sets
   `AGENT_STATUS=1` in the tmux environment, which only new shells pick up.
   Both `scripts/agent-state.sh` (called by the hooks) and the zsh precmd hook
   in `sourceme.sh` do nothing without it.

### Disabling it

Delete the host file and restart the tmux server. Reloading the config is
not enough: it leaves the `a`/`A` bindings and the `pane-focus-in` hook in
place.

### How it works

- Claude Code hooks call `scripts/agent-state.sh`, which sets the pane option
  `@agent_state` (`idle`, `working`, `blocked`, `done`) on `$TMUX_PANE`.
- `scripts/agent-list.sh` lists tagged panes, most urgent first. The summary,
  jump and picker scripts all use it.
- A pane whose foreground process is a shell counts as stale and is ignored.
  The zsh precmd hook also clears the tag whenever a prompt comes back.
- Focusing a `done` pane turns it `idle`.
