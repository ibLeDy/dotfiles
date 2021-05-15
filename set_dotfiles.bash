#!/usr/bin/env bash

DOTFILES_HOME="$HOME/workspace/repos/dotfiles"
DOTFILES_CONFIG_HOME="$DOTFILES_HOME/.config"
DOTFILES_LOCAL_BIN="$DOTFILES_HOME/.local/bin"
DOTFILES_ETC="$DOTFILES_HOME/etc"

# $HOME
cp $DOTFILES_HOME/.bashrc ~/
cp $DOTFILES_HOME/.dmrc ~/
cp $DOTFILES_HOME/.pdbrc ~/
cp $DOTFILES_HOME/.profile ~/
cp $DOTFILES_HOME/.tmux.conf ~/

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{git,htop,vim}
cp $DOTFILES_CONFIG_HOME/aliasrc ~/.config
cp $DOTFILES_CONFIG_HOME/git/{config,ignore} ~/.config/git/
cp $DOTFILES_CONFIG_HOME/htop/htoprc ~/.config/htop/
cp $DOTFILES_CONFIG_HOME/vim/vimrc ~/.config/vim/

# $HOME/.local/bin
mkdir -p ~/.local/bin
cp $DOTFILES_LOCAL_BIN/countdown ~/.local/bin/

# /etc
cp $DOTFILES_ETC/dhcpcd.conf /etc

