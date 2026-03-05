# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io) + [mise](https://mise.jdx.dev).
Works on macOS and Linux. No sudo required.

---

## Quick start

### Prerequisites

Only `curl` and `git` are needed. On a fresh Linux machine:

```bash
apt-get install -y curl git   # Debian/Ubuntu
dnf install -y curl git       # Fedora
```

macOS ships both (`xcode-select --install` if missing).

### Bootstrap

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/japostadan/dotfiles/main/bootstrap)"
```

Or clone and run directly (useful when testing local changes):

```bash
git clone https://github.com/japostadan/dotfiles.git ~/dotfiles
bash ~/dotfiles/bootstrap
```

After bootstrap finishes, open a new shell:

```bash
exec zsh
```

---

## What gets installed

Everything lands in `~/.local/bin` via mise — no root access needed.

### CLI tools

| Tool | Purpose |
|------|---------|
| neovim | Editor |
| tmux | Terminal multiplexer |
| lazygit | Git TUI |
| gh | GitHub CLI |
| fzf | Fuzzy finder |
| fd | Better `find` |
| ripgrep | Better `grep` |
| delta | Syntax-highlighted git diffs |
| jq | JSON processor |
| bat | Better `cat` |
| lsd | Better `ls` |
| yazi | Terminal file manager |
| zoxide | Smart `cd` |
| direnv | Per-directory env vars |
| k9s | Kubernetes TUI |
| go | Go runtime (for LSP tools) |

### Node

Node.js is managed by [nvm](https://github.com/nvm-sh/nvm) (not mise) for better version switching:

```bash
nvm install --lts     # install latest LTS
nvm use --lts         # switch to it
nvm alias default lts # make it the default
```

### Zsh plugins

Managed as chezmoi git externals — cloned automatically to `~/.zsh/`:

- **pure** — minimal prompt
- **zsh-autosuggestions** — fish-like suggestions as you type
- **zsh-syntax-highlighting** — colors commands before you run them

### Terminal

**kitty** is the terminal emulator. On macOS install it via brew:

```bash
brew install --cask kitty
```

On Linux, download from [sw.kovidgoyal.net/kitty](https://sw.kovidgoyal.net/kitty/).
kitty requires a GUI and is not installed via mise.

---

## How it works

```
bootstrap
  └── installs chezmoi
  └── chezmoi init --apply
        └── applies all dotfiles to ~
        └── downloads mise binary  (~/.local/bin/mise)
        └── clones zsh plugins     (~/.zsh/)
  └── runs setup
        └── installs all mise tools
        └── installs nvm + Node LTS
```

chezmoi keeps the source at `~/.local/share/chezmoi/` and maps files to `~`:

| Source | Destination |
|--------|------------|
| `dot_zshrc` | `~/.zshrc` |
| `dot_config/nvim/` | `~/.config/nvim/` |
| `dot_config/tmux/` | `~/.config/tmux/` |
| `dot_config/kitty/` | `~/.config/kitty/` |
| `dot_config/mise/` | `~/.config/mise/` |

---

## Daily workflow

### Editing dotfiles

Always edit files through chezmoi so changes are tracked:

```bash
chezmoi edit ~/.zshrc          # opens in $EDITOR
chezmoi edit ~/.config/tmux/tmux.conf

chezmoi diff                   # preview what would change
chezmoi apply                  # apply changes to ~
```

Or edit the source directly and apply:

```bash
cd ~/.local/share/chezmoi      # the git repo
v dot_zshrc                    # edit with nvim
chezmoi apply                  # push changes to ~
```

The `dot` alias takes you there faster:

```bash
dot        # cd to dotfiles source dir
```

### Saving changes to GitHub

```bash
dot                     # go to source dir
gs                      # git status
ga dot_zshrc            # stage changed file
gcm "update zshrc"      # commit
gp                      # push
```

### Pulling updates on another machine

```bash
chezmoi update          # git pull + apply in one step
mise install            # install any newly added tools
```

### Adding a new tool

1. Add it to `dot_config/mise/config.toml`
2. Run `chezmoi apply && mise install`
3. Commit and push

```bash
# Example: add httpie
echo 'httpie = "latest"' >> ~/.local/share/chezmoi/dot_config/mise/config.toml
chezmoi apply
mise install
```

### Adding a new dotfile

```bash
chezmoi add ~/.config/somtool/config    # start tracking a new file
chezmoi edit ~/.config/sometool/config  # edit it
chezmoi apply                           # apply
```

---

## Key aliases

| Alias | Command |
|-------|---------|
| `v` | nvim |
| `lg` | lazygit |
| `y` | yazi |
| `t` / `ta` | tmux / tmux attach |
| `k` | kubectl |
| `gs` / `gp` / `gl` | git status / push / pull |
| `ls` / `la` | lsd / lsd -la |
| `dot` | cd to dotfiles source |
| `reload` | source ~/.zshrc |
| `edt` | nvim via fzf file picker |

---

## Tmux keybindings

Prefix is `Ctrl+b` (default).

| Key | Action |
|-----|--------|
| `prefix + \|` | Split vertical |
| `prefix + -` | Split horizontal |
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + H/J/K/L` | Resize pane |
| `prefix + q` | Kill pane |
| `prefix + Q` | Kill window |
| `prefix + g` | Lazygit popup |
| `prefix + r` | Reload tmux config |

---

## Updating a single tool

```bash
mise install ripgrep@latest    # upgrade one tool
mise upgrade                   # upgrade all tools
```

---

## Removing a tool

1. Delete the line from `dot_config/mise/config.toml`
2. Run `chezmoi apply`
3. Run `mise prune` to remove unused versions

---

## Troubleshooting

**Pure prompt not showing**
```bash
chezmoi apply    # re-runs chezmoi externals, clones ~/.zsh/pure
exec zsh
```

**Tool not found after bootstrap**
```bash
mise list        # check it was installed
mise doctor      # check for issues
```

**Changes not applying**
```bash
chezmoi diff     # see what's pending
chezmoi apply -v # apply with verbose output
```
