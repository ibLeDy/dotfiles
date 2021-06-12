#!/usr/bin/env bash

DOTFILES_HOME="$HOME/workspace/repos/dotfiles"
DOTFILES_CONFIG_HOME="$DOTFILES_HOME/.config"
DOTFILES_LOCAL_BIN="$DOTFILES_HOME/.local/bin"
DOTFILES_ETC="$DOTFILES_HOME/etc"
DOTFILES_USR_SHARE="$DOTFILES_HOME/usr/share"

# $HOME
cp ~/.bashrc $DOTFILES_HOME
cp ~/.dmrc $DOTFILES_HOME
cp ~/.pdbrc $DOTFILES_HOME
cp ~/.profile $DOTFILES_HOME
cp ~/.tmux.conf $DOTFILES_HOME

# $XDG_CONFIG_HOME
mkdir -p $DOTFILES_CONFIG_HOME/{git,htop,vim,zellij}
cp ~/.config/aliasrc $DOTFILES_CONFIG_HOME
cp ~/.config/git/{config,ignore} $DOTFILES_CONFIG_HOME/git/
cp ~/.config/htop/htoprc $DOTFILES_CONFIG_HOME/htop/
cp ~/.config/vim/vimrc $DOTFILES_CONFIG_HOME/vim/
cp ~/.config/zellij/config.yaml $DOTFILES_CONFIG_HOME/zellij/

# $HOME/.local/bin
mkdir -p $DOTFILES_LOCAL_BIN
cp ~/.local/bin/countdown $DOTFILES_LOCAL_BIN

# /etc
mkdir -p $DOTFILES_ETC
cp /etc/dhcpcd.conf $DOTFILES_ETC

# /usr/share
mkdir -p $DOTFILES_USR_SHARE/grc
cp /usr/share/grc/conf.odoo $DOTFILES_USR_SHARE/grc/
