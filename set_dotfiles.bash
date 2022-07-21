#!/usr/bin/env bash

DOTFILES_HOME=$( dirname -- "$0"; )
DOTFILES_CONFIG_HOME=$DOTFILES_HOME/.config
DOTFILES_LOCAL_BIN=$DOTFILES_HOME/.local/bin
DOTFILES_LOCAL_SHARE=$DOTFILES_HOME/.local/share
# TODO: Add a check for $XDG_CONFIG_HOME and use variables for the destinations
# TODO: Use symbolic links for every file

# $HOME
mkdir -p ~/.cache
cp $DOTFILES_HOME/.bashrc ~/
cp $DOTFILES_HOME/.pdbrc ~/
cp $DOTFILES_HOME/.zprofile ~/

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{alacritty,flameshot,git,htop,lsd,tmux,vim,zellij,zsh}
mkdir -p ~/Library/Application\ Support/Code/User/
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
cp $DOTFILES_CONFIG_HOME/aliasrc ~/.config/
cp $DOTFILES_CONFIG_HOME/alacritty/alacritty.yml ~/.config/alacritty/
cp $DOTFILES_CONFIG_HOME/Code/User/{keybindings,settings}.json ~/Library/Application\ Support/Code/User/
#cp $DOTFILES_CONFIG_HOME/flameshot/flameshot.conf ~/.config/flameshot/
cp $DOTFILES_CONFIG_HOME/git/{config,ignore} ~/.config/git/
#cp $DOTFILES_CONFIG_HOME/htop/htoprc ~/.config/htop/
cp $DOTFILES_CONFIG_HOME/lsd/config.yaml ~/.config/lsd/
cp $DOTFILES_CONFIG_HOME/sublime-text/Packages/User/{'Default (OSX).sublime-keymap',Preferences.sublime-settings} ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
cp $DOTFILES_CONFIG_HOME/tmux/tmux.conf ~/.config/tmux/
cp $DOTFILES_CONFIG_HOME/vim/vimrc ~/.config/vim/
cp $DOTFILES_CONFIG_HOME/zellij/config.yaml ~/.config/zellij/
cp $DOTFILES_CONFIG_HOME/zsh/.{p10k.zsh,zshrc} ~/.config/zsh/

# $HOME/.gnupg
mkdir -p ~/.gnupg
cp $DOTFILES_HOME/.gnupg/gpg-agent.conf ~/.gnupg

# $HOME/.local/bin
mkdir -p ~/.local/bin
cp $DOTFILES_LOCAL_BIN/{countdown,mute-spotify-ads} ~/.local/bin/

# $HOME/.ssh
mkdir -p ~/.ssh
cp $DOTFILES_HOME/.ssh/config ~/.ssh/

# $HOME/.local/share
mkdir -p ~/.local/share/zellij/{layouts,plugins}
cp $DOTFILES_LOCAL_SHARE/zellij/layouts/{default,strider}.yaml ~/.local/share/zellij/layouts/
cp $DOTFILES_LOCAL_SHARE/zellij/plugins/{status-bar,strider,tab-bar}.wasm ~/.local/share/zellij/plugins/
