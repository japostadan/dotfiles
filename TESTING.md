# Testing Guide

## Prerequisites

The bootstrap requires `curl` and `git`. On a fresh Linux machine install them first:

```bash
# Debian/Ubuntu
apt-get update && apt-get install -y curl git

# Fedora
dnf install -y curl git
```

macOS ships both (`xcode-select --install` if missing).

---

## Method 1: Clone and run (best for testing local changes)

Use this when your changes haven't been pushed to GitHub yet.

```bash
git clone https://github.com/japostadan/dotfiles.git ~/dotfiles-test
bash ~/dotfiles-test/bootstrap
exec zsh
```

To test only the tool installation without re-applying dotfiles:

```bash
bash ~/dotfiles-test/setup
```

---

## Method 2: One-liner curl (tests the full remote flow)

Only use this after pushing changes to GitHub. Tests the exact path a new user would follow.

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/japostadan/dotfiles/main/bootstrap)"
exec zsh
```

---

## Method 3: Docker — clean Linux machine

The most reliable way to catch missing deps and no-sudo failures.

### Ubuntu (primary test target)

```bash
docker run -it --rm ubuntu:22.04 bash
```

Inside the container:

```bash
apt-get update && apt-get install -y curl git

# Option A — test local changes (mount repo)
# Run from outside the container:
# docker run -it --rm -v $(pwd):/dotfiles ubuntu:22.04 bash
# Then inside: bash /dotfiles/bootstrap

# Option B — test the live GitHub version
sh -c "$(curl -fsLS https://raw.githubusercontent.com/japostadan/dotfiles/main/bootstrap)"
exec zsh
```

### Mount local repo into Docker (no push needed)

```bash
docker run -it --rm \
  -v /Users/eye/Repos/github.com/japostadan/dotfiles:/dotfiles \
  ubuntu:22.04 bash

# Inside the container:
apt-get update && apt-get install -y curl git
bash /dotfiles/bootstrap
exec zsh
```

### Other distributions

```bash
docker run -it --rm debian:12 bash
docker run -it --rm fedora:40 bash
```

Install `curl git` first in each, then run bootstrap.

---

## Method 4: macOS idempotency check

Verifies that re-applying on your own machine changes nothing unexpected.

```bash
chezmoi diff             # should show no diff if already applied
chezmoi apply --verbose  # apply and check for errors
exec zsh                 # reload shell
```

---

## Verification checklist

Run after any bootstrap to confirm everything works.

### Tools present

```bash
which nvim tmux lazygit gh fzf fd rg delta jq bat lsd yazi zoxide direnv k9s go
```

### All in ~/.local/bin

```bash
ls ~/.local/bin
```

### mise manages them correctly

```bash
mise list        # shows all tools and installed versions
mise doctor      # checks for any issues
```

### Node via nvm

```bash
node --version   # should show LTS version
nvm list         # shows installed node versions
```

### Zsh plugins loaded

```bash
exec zsh
# Type a command you've run before — autosuggestions should appear in grey
# Type an invalid command — syntax highlighting should show it in red
```

### No sudo was used

```bash
grep -r sudo bootstrap setup
# Should return nothing
```

---

## Manual feature checks

| Feature | How to verify |
|---------|--------------|
| Pure prompt | Open new shell — prompt shows current dir + git branch |
| zsh-autosuggestions | Type `git` — previous git command appears in grey, `→` accepts it |
| zsh-syntax-highlighting | Type `gti` (typo) — appears red; type `git` — appears green |
| zoxide | `cd` into any dir, `cd ~`, type the dir name and press enter |
| fzf history | `Ctrl+R` — fuzzy search through shell history |
| fzf files | `Ctrl+T` — fuzzy file picker |
| lazygit | Run `lg` inside a git repo |
| yazi | Run `y` — file manager opens with vim-key navigation |
| delta | Run `git diff` — output should have syntax highlighting |
| neovim | Run `v` — LazyVim loads with plugins |
| lsd | Run `ls` — shows icons and colour |
| bat | Run `bat <any file>` — syntax highlighting |
| k9s | Run `k9s` inside a cluster context — Kubernetes TUI loads |
| direnv | Create a `.envrc` in a dir, run `direnv allow` — vars load on `cd` |
| kitty | Open kitty — Tokyo Night theme, JetBrainsMono font, powerline tabs |
| tmux lazygit | Inside tmux: `prefix + g` — lazygit popup opens |

---

## Troubleshooting

**`chezmoi init` fails in Docker**
Make sure `git` is installed — chezmoi uses it internally to clone the repo.

**Tool not found after bootstrap**
```bash
mise list        # check it shows as installed
mise doctor      # check for missing system libraries
exec zsh         # reload PATH
```

**Pure prompt not loading**
```bash
ls ~/.zsh/pure/          # check pure was cloned
chezmoi apply            # re-run externals if the dir is missing
exec zsh
```

**fzf `--zsh` flag errors**
Requires fzf ≥ 0.48. Run `mise upgrade fzf` to update.

**nvm not found after setup**
nvm is a shell function, not a binary. It only works after sourcing `.zshrc`:
```bash
exec zsh
nvm --version
```

**zsh plugins not loading**
```bash
ls ~/.zsh/                          # check dirs exist
chezmoi apply                       # re-run externals
source ~/.zshrc
```

**direnv not hooking**
```bash
direnv --version         # check it's installed
echo $PATH | tr : '\n' | grep local   # check ~/.local/bin is on PATH
```
