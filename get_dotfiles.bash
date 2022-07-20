#!/usr/bin/env bash

DOTFILES_HOME=$( dirname -- "$0"; )
DOTFILES_CONFIG_HOME=$DOTFILES_HOME/.config
DOTFILES_LOCAL_BIN=$DOTFILES_HOME/.local/bin
DOTFILES_LOCAL_SHARE=$DOTFILES_HOME/.local/share

# $HOME
cp ~/.asoundrc $DOTFILES_HOME
cp ~/.bashrc $DOTFILES_HOME
cp ~/.imwheelrc $DOTFILES_HOME
cp ~/.pdbrc $DOTFILES_HOME
cp ~/.profile $DOTFILES_HOME

# $XDG_CONFIG_HOME
mkdir -p $DOTFILES_CONFIG_HOME/{alacritty,Code/User,dash-to-panel,flameshot,git,gnome-extensions-sync,htop,i3,i3blocks,lsd,mpv,nano,pulse,sublime-text/Packages/User,tmux,tiling-assistant,vim,zellij,zsh}
cp ~/.config/aliasrc $DOTFILES_CONFIG_HOME
cp ~/.config/alacritty/alacritty.yml $DOTFILES_CONFIG_HOME/alacritty/
cp ~/.config/Code/User/{keybindings.json,settings.json} $DOTFILES_CONFIG_HOME/Code/User/
cp ~/.config/dash-to-panel/dash-to-panel-settings $DOTFILES_CONFIG_HOME/dash-to-panel/
cp ~/.config/flameshot/flameshot.conf $DOTFILES_CONFIG_HOME/flameshot/
cp ~/.config/git/{config,ignore} $DOTFILES_CONFIG_HOME/git/
cp ~/.config/gnome-extensions-sync/extensions.json $DOTFILES_CONFIG_HOME/gnome-extensions-sync
cp ~/.config/htop/htoprc $DOTFILES_CONFIG_HOME/htop/
cp ~/.config/i3/config $DOTFILES_CONFIG_HOME/i3/
cp ~/.config/i3blocks/config $DOTFILES_CONFIG_HOME/i3blocks/
cp ~/.config/lsd/config.yaml $DOTFILES_CONFIG_HOME/lsd/
cp ~/.config/mpv/mpv.conf $DOTFILES_CONFIG_HOME/mpv/
cp ~/.config/nano/nanorc $DOTFILES_CONFIG_HOME/nano/
cp ~/.config/pulse/{daemon.conf,default.pa} $DOTFILES_CONFIG_HOME/pulse/
cp ~/.config/sublime-text/Packages/User/{'Default (Linux).sublime-keymap','Package Control.sublime-settings',Preferences.sublime-settings} $DOTFILES_CONFIG_HOME/sublime-text/Packages/User/
cp ~/.config/tmux/tmux.conf $DOTFILES_CONFIG_HOME/tmux/
cp ~/.config/tiling-assistant/layouts.json $DOTFILES_CONFIG_HOME/tiling-assistant/
cp ~/.config/vim/vimrc $DOTFILES_CONFIG_HOME/vim/
cp ~/.config/zellij/config.yaml $DOTFILES_CONFIG_HOME/zellij/
cp ~/.config/zsh/.{p10k.zsh,zshrc} $DOTFILES_CONFIG_HOME/zsh/

# $HOME/.local/bin
mkdir -p $DOTFILES_LOCAL_BIN
# cp ~/.local/bin/{countdown,extramaus,fix-volume,mute-spotify-ads} $DOTFILES_LOCAL_BIN
cp ~/.local/bin/fix-screen-tearing $DOTFILES_LOCAL_BIN

# $HOME/.local/share
mkdir -p $DOTFILES_LOCAL_SHARE/zellij/{layouts,plugins}
cp ~/.local/share/zellij/layouts/{default,strider}.yaml $DOTFILES_LOCAL_SHARE/zellij/layouts
cp ~/.local/share/zellij/plugins/* $DOTFILES_LOCAL_SHARE/zellij/plugins
