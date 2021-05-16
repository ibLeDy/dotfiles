#!/usr/bin/env bash

DOTFILES_HOME="$HOME/workspace/repos/ibLeDy/dotfiles"
DOTFILES_CONFIG_HOME="$DOTFILES_HOME/.config"
DOTFILES_LOCAL_BIN="$DOTFILES_HOME/.local/bin"
DOTFILES_LOCAL_SHARE="$DOTFILES_HOME/.local/share"

# $HOME
cp $DOTFILES_HOME/.asoundrc ~/
cp $DOTFILES_HOME/.imwheelrc ~/
cp $DOTFILES_HOME/.pdbrc ~/
cp $DOTFILES_HOME/.profile ~/

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{alacritty,Code/User,dash-to-panel,flameshot,git,gnome-extensions-sync,htop,i3,i3blocks,mpv,pulse,sublime-text-3/Packages/User,tmux,tiling-assistant,vim,zellij,zsh}
cp $DOTFILES_CONFIG_HOME/aliasrc ~/.config
cp $DOTFILES_CONFIG_HOME/alacritty/alacritty.yml ~/.config/alacritty/
cp $DOTFILES_CONFIG_HOME/Code/User/{keybindings.json,settings.json} ~/.config/Code/User/
cp $DOTFILES_CONFIG_HOME/dash-to-panel/dash-to-panel-settings ~/.config/dash-to-panel/
cp $DOTFILES_CONFIG_HOME/flameshot/flameshot.conf ~/.config/flameshot/
cp $DOTFILES_CONFIG_HOME/git/{config,ignore} ~/.config/git/
cp $DOTFILES_CONFIG_HOME/gnome-extensions-sync/extensions.json ~/.config/gnome-extensions-sync/
cp $DOTFILES_CONFIG_HOME/htop/htoprc ~/.config/htop/
cp $DOTFILES_CONFIG_HOME/i3/config ~/.config/i3/
cp $DOTFILES_CONFIG_HOME/i3blocks/config ~/.config/i3blocks/
cp $DOTFILES_CONFIG_HOME/mpv/mpv.conf ~/.config/mpv/
cp $DOTFILES_CONFIG_HOME/pulse/daemon.conf ~/.config/pulse/
cp $DOTFILES_CONFIG_HOME/sublime-text-3/Packages/User/{"Default (Linux).sublime-keymap","Package Control.sublime-settings",Preferences.sublime-settings} ~/.config/sublime-text-3/Packages/User/
cp $DOTFILES_CONFIG_HOME/tmux/tmux.conf ~/.config/tmux/
cp $DOTFILES_CONFIG_HOME/tiling-assistant/layouts.json ~/.config/tiling-assistant/
cp $DOTFILES_CONFIG_HOME/vim/vimrc ~/.config/vim/
cp $DOTFILES_CONFIG_HOME/zellij/config.yaml ~/.config/zellij/
cp $DOTFILES_CONFIG_HOME/zsh/.{p10k.zsh,zshrc} ~/.config/zsh/

# $HOME/.local/bin
mkdir -p ~/.local/bin
# cp .local/bin/{countdown,extramaus,fix-volume,mute-spotify-ads} ~/.local/bin/
cp $DOTFILES_LOCAL_BIN/fix-screen-tearing ~/.local/bin/fix-screen-tearing

# $HOME/.local/share
mkdir -p ~/.local/share/zellij/{layouts,plugins}
cp $DOTFILES_LOCAL_SHARE/zellij/layouts/{default,strider}.yaml ~/.local/share/zellij/layouts/
cp $DOTFILES_LOCAL_SHARE/zellij/plugins/* ~/.local/share/zellij/plugins/
