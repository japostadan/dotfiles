# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io) + [mise](https://mise.jdx.dev).
Works on macOS and Linux. **No sudo required.**

## Bootstrap (one-liner)

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/japostadan/dotfiles/main/bootstrap)"
```

Requires only `curl`, `git`, and `bash` — present on virtually every machine.

## What gets installed

All tools land in `~/.local/bin` via mise — no root access needed:

| Tool | Purpose |
|------|---------|
| neovim | Editor |
| tmux | Terminal multiplexer |
| starship | Shell prompt |
| lazygit | Git TUI |
| fzf | Fuzzy finder |
| zoxide | Smart `cd` |
| ripgrep | Fast grep |
| bat | Better `cat` |
| lsd | Better `ls` |
| node | JavaScript runtime |
| go | Go runtime (for LSP tools) |

## How it works

1. `bootstrap` downloads chezmoi and applies this repo via HTTPS
2. chezmoi places `~/.config/mise/config.toml` and all other configs
3. mise installs every tool declared in that config to `~/.local/bin`
4. New shell session picks up `~/.local/bin` via `$PATH` in `.zshrc`

## Adding a new machine

```bash
# On any machine with curl + git:
sh -c "$(curl -fsLS https://raw.githubusercontent.com/japostadan/dotfiles/main/bootstrap)"
```

## Updating dotfiles

```bash
chezmoi update   # pull latest from GitHub and re-apply
mise install     # install any new tools added to mise config
```
