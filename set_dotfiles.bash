#!/usr/bin/env bash

DOTFILES_HOME="$HOME/workspace/repos/dotfiles"
DOTFILES_CONFIG_HOME="$DOTFILES_HOME/.config"
DOTFILES_LOCAL_BIN="$DOTFILES_HOME/.local/bin"
DOTFILES_ETC="$DOTFILES_HOME/etc"
DOTFILES_USR_SHARE="$DOTFILES_HOME/usr/share"

# $HOME
cp $DOTFILES_HOME/.bashrc ~/
cp $DOTFILES_HOME/.dmrc ~/
cp $DOTFILES_HOME/.pdbrc ~/
cp $DOTFILES_HOME/.profile ~/
cp $DOTFILES_HOME/.tmux.conf ~/

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{git,htop,vim,zellij}
mkdir -p ~/.config/systemd/user
cp $DOTFILES_CONFIG_HOME/aliasrc ~/.config
cp $DOTFILES_CONFIG_HOME/git/{config,ignore} ~/.config/git/
cp $DOTFILES_CONFIG_HOME/htop/htoprc ~/.config/htop/
cp $DOTFILES_CONFIG_HOME/vim/vimrc ~/.config/vim/
cp $DOTFILES_CONFIG_HOME/zellij/config.yaml ~/.config/zellij/

# $HOME/.local/bin
mkdir -p ~/.local/bin
cp $DOTFILES_LOCAL_BIN/countdown ~/.local/bin/

# /usr/share
mkdir -p /usr/share/grc
cp $DOTFILES_USR_SHARE/grc/conf.odoo /usr/share/grc/
