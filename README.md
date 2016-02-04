# dotfiles

This is dotfiles for Tasuku SUENAGA a.k.a. gunyarakun.

## Install

```
git clone https://github.com/gunyarakun/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install # installing some basic softwares
./bootstrap # install .vimrc/.gitconfig/.zshrc/.zshenv etc.
```

## Install plenv/rbenv/pyenv/nodenv

```
cd ~/dotfiles
./langenv-fetch # installing *env
source ~/.zshrc
./langenv-install # installing languages with *env
```
