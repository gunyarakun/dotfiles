# dotfiles

This is dotfiles for Tasuku SUENAGA a.k.a. gunyarakun.

## Install

```
git clone --recursive https://github.com/gunyarakun/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install # Homebrew check on macOS, apt/yum packages on Linux
curl https://mise.run | sh
~/.local/bin/mise trust
~/.local/bin/mise bootstrap # packages, dotfiles, languages and tools
```

On a new Mac, run `mise bootstrap` twice: Mac App Store apps need `mas`,
which the first run installs.

## Update

```
cd ~/dotfiles
git pull
mise bootstrap
```

- `mise.toml`: dotfiles shared by all machines and setup steps
- `mise.macos.toml`: Homebrew / Mac App Store packages and macOS-only dotfiles
- `mise/config.toml`: global mise tools, linked to `~/.config/mise/config.toml`
