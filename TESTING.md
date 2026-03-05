# Testing Guide

## Quick local check

Verify the configs are valid before pushing anything.

```bash
# Check zshrc for syntax errors
zsh -n ~/.local/share/chezmoi/dot_zshrc

# See what chezmoi would change (without applying)
chezmoi diff

# Check mise config is valid and list managed tools
mise config ls
```

---

## Docker — clean Linux machine (recommended)

The most reliable way to test the full bootstrap on a fresh no-sudo Linux machine.

### Ubuntu (apt)

```bash
docker run -it --rm ubuntu:22.04 bash
```

Inside the container:

```bash
apt-get update && apt-get install -y curl git bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/japostadan/dotfiles/main/bootstrap)"
exec zsh
```

### Other distributions

```bash
# Debian
docker run -it --rm debian:12 bash

# Fedora
docker run -it --rm fedora:40 bash

# Alpine (minimal)
docker run -it --rm alpine:3.19 sh
```

Run the same two commands inside each container after starting it.

---

## macOS — test idempotency

Check that running chezmoi apply again on your own machine changes nothing unexpected.

```bash
chezmoi diff           # should show no diff if already applied
chezmoi apply --verbose
exec zsh               # reload shell to verify prompt and integrations
```

---

## Dry-run the scripts

Run bootstrap and setup in trace mode without committing to a full install.

```bash
# Trace bootstrap execution
bash -x bootstrap 2>&1 | head -60

# Run setup in a subshell (isolates env changes)
( bash -x setup )
```

---

## No-sudo simulation on macOS

Create a local user without admin rights and run the bootstrap as that user.

```bash
sudo dscl . -create /Users/testuser
sudo dscl . -create /Users/testuser UserShell /bin/zsh
sudo dscl . -create /Users/testuser UniqueID 502
sudo dscl . -create /Users/testuser PrimaryGroupID 20
sudo dscl . -create /Users/testuser NFSHomeDirectory /Users/testuser
sudo createhomedir -c -u testuser

su - testuser
sh -c "$(curl -fsLS https://raw.githubusercontent.com/japostadan/dotfiles/main/bootstrap)"
```

Clean up afterwards:

```bash
sudo dscl . -delete /Users/testuser
sudo rm -rf /Users/testuser
```

---

## Verification checklist

Run these after any bootstrap to confirm everything works.

```bash
# Tools installed and reachable
which nvim tmux lazygit zoxide fzf bat lsd rg node go

# All binaries land in ~/.local/bin (not /usr/local or /usr/bin)
ls ~/.local/bin

# mise manages the expected tools
mise list

# No sudo was used anywhere in the scripts
grep -r sudo bootstrap setup
```

### Manual checks

| Feature | How to verify |
|---------|--------------|
| Pure prompt | Open a new shell — prompt should render with git info |
| zoxide | `cd` into any dir, go back home, type the dir name |
| fzf history | Press `Ctrl+R` |
| fzf file search | Press `Ctrl+T` |
| lazygit | Run `lg` inside a git repo |
| neovim | Run `v` — should open with LazyVim |
| lsd | Run `ls` — should show icons and color |
| bat | Run `bat <any file>` — should show syntax highlighting |

---

## Expected result

After a successful bootstrap on any machine:

- All tools available under `~/.local/bin`
- Shell opens with the pure prompt
- No errors on `exec zsh`
- `mise list` shows all tools with their installed versions
- Zero sudo calls were made
