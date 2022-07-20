#!/usr/bin/env bash

DOTFILES_HOME=$( dirname -- "$0"; )
DOTFILES_CONFIG_HOME=$DOTFILES_HOME/.config
DOTFILES_LOCAL_SHARE=$DOTFILES_HOME/.local/share

# $HOME
cp $DOTFILES_HOME/.bashrc ~/
cp $DOTFILES_HOME/.pdbrc ~/
cp $DOTFILES_HOME/.profile ~/

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{git,htop,lsd,nano,tmux,vim,zellij,zsh}
cp $DOTFILES_CONFIG_HOME/aliasrc ~/.config
cp $DOTFILES_CONFIG_HOME/git/{config,ignore} ~/.config/git/
cp $DOTFILES_CONFIG_HOME/htop/htoprc ~/.config/htop/
cp $DOTFILES_CONFIG_HOME/lsd/config.yaml ~/.config/lsd/
cp $DOTFILES_CONFIG_HOME/nano/nanorc ~/.config/nano/
cp $DOTFILES_CONFIG_HOME/tmux/tmux.conf ~/.config/tmux/
cp $DOTFILES_CONFIG_HOME/vim/vimrc ~/.config/vim/
cp $DOTFILES_CONFIG_HOME/zellij/config.yaml ~/.config/zellij/
cp $DOTFILES_CONFIG_HOME/zsh/.{p10k.zsh,zshrc} ~/.config/zsh/

# $HOME/.local/share
mkdir -p ~/.local/share/zellij/{layouts,plugins}
cp $DOTFILES_LOCAL_SHARE/zellij/layouts/{default,strider}.yaml ~/.local/share/zellij/layouts/
cp $DOTFILES_LOCAL_SHARE/zellij/plugins/* ~/.local/share/zellij/plugins/
