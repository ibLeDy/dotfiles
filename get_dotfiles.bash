#!/usr/bin/env bash

DOTFILES_HOME=$( dirname -- "$0"; )
DOTFILES_CONFIG_HOME=$DOTFILES_HOME/.config
DOTFILES_LOCAL_BIN=$DOTFILES_HOME/.local/bin
DOTFILES_LOCAL_SHARE=$DOTFILES_HOME/.local/share

# $HOME
cp ~/.bashrc $DOTFILES_HOME
cp ~/.pdbrc $DOTFILES_HOME
cp ~/.zprofile $DOTFILES_HOME

# $XDG_CONFIG_HOME
mkdir -p $DOTFILES_CONFIG_HOME/{alacritty,Code/User,flameshot,git,htop,lsd,sublime-text/Packages/User,tmux,vim,zellij,zsh}
cp ~/.config/aliasrc $DOTFILES_CONFIG_HOME/
cp ~/.config/alacritty/alacritty.yml $DOTFILES_CONFIG_HOME/alacritty/
cp ~/Library/Application\ Support/Code/User/{keybindings,settings}.json $DOTFILES_CONFIG_HOME/Code/User/
cp ~/.config/flameshot/flameshot.conf $DOTFILES_CONFIG_HOME/flameshot/
cp ~/.config/git/{config,ignore} $DOTFILES_CONFIG_HOME/git/
cp ~/.config/htop/htoprc $DOTFILES_CONFIG_HOME/htop/
cp ~/.config/lsd/config.yaml $DOTFILES_CONFIG_HOME/lsd/
cp ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/{'Default (OSX).sublime-keymap','Package Control.sublime-settings',Preferences.sublime-settings} $DOTFILES_CONFIG_HOME/sublime-text/Packages/User/
cp ~/.config/tmux/tmux.conf $DOTFILES_CONFIG_HOME/tmux/
cp ~/.config/vim/vimrc $DOTFILES_CONFIG_HOME/vim/
cp ~/.config/zellij/config.yaml $DOTFILES_CONFIG_HOME/zellij/
cp ~/.config/zsh/.{p10k.zsh,zshrc} $DOTFILES_CONFIG_HOME/zsh/

# $HOME/.gnupg
mkdir -p $DOTFILES_HOME/.gnupg/
cp ~/.gnupg/gpg-agent.conf $DOTFILES_HOME/.gnupg/

# $HOME/.local/bin
mkdir -p $DOTFILES_LOCAL_BIN
cp ~/.local/bin/{countdown,mute-spotify-ads} $DOTFILES_LOCAL_BIN

# $HOME/.ssh
mkdir -p $DOTFILES_HOME/.ssh/
cp ~/.ssh/config $DOTFILES_HOME/.ssh/

# $HOME/.local/share
mkdir -p $DOTFILES_LOCAL_SHARE/zellij/{layouts,plugins}
cp ~/.local/share/zellij/layouts/{default,strider}.yaml $DOTFILES_LOCAL_SHARE/zellij/layouts/
cp ~/.local/share/zellij/plugins/{status-bar,strider,tab-bar}.wasm $DOTFILES_LOCAL_SHARE/zellij/plugins/
