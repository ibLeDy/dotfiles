#!/usr/bin/env bash

DOTFILES_HOME=$HOME/workspace/repos/ibLeDy/dotfiles
DOTFILES_CONFIG_HOME=$DOTFILES_HOME/.config
DOTFILES_LOCAL_SHARE=$DOTFILES_HOME/.local/share

# $HOME
cp ~/.pdbrc $DOTFILES_HOME
cp ~/.profile $DOTFILES_HOME

# $XDG_CONFIG_HOME
mkdir -p $DOTFILES_CONFIG_HOME/{git,htop,lsd,nano,tmux,vim,zellij,zsh}
cp ~/.config/aliasrc $DOTFILES_CONFIG_HOME
cp ~/.config/git/{config,ignore} $DOTFILES_CONFIG_HOME/git/
cp ~/.config/htop/htoprc $DOTFILES_CONFIG_HOME/htop/
cp ~/.config/lsd/config.yaml $DOTFILES_CONFIG_HOME/lsd/
cp ~/.config/nano/nanorc $DOTFILES_CONFIG_HOME/nano/
cp ~/.config/tmux/tmux.conf $DOTFILES_CONFIG_HOME/tmux/
cp ~/.config/vim/vimrc $DOTFILES_CONFIG_HOME/vim/
cp ~/.config/zellij/config.yaml $DOTFILES_CONFIG_HOME/zellij/
cp ~/.config/zsh/.{p10k.zsh,zshrc} $DOTFILES_CONFIG_HOME/zsh/

# $HOME/.local/share
mkdir -p $DOTFILES_LOCAL_SHARE/zellij/{layouts,plugins}
cp ~/.local/share/zellij/layouts/{default,strider}.yaml $DOTFILES_LOCAL_SHARE/zellij/layouts
cp ~/.local/share/zellij/plugins/* $DOTFILES_LOCAL_SHARE/zellij/plugins
