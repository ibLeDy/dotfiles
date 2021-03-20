#!/usr/bin/env bash

DOTFILES_HOME="$HOME/workspace/dotfiles"
DOTFILES_CONFIG_HOME="$DOTFILES_HOME/.config"
DOTFILES_LOCAL_BIN="$DOTFILES_HOME/.local/bin"
DOTFILES_ETC="$DOTFILES_HOME/etc"
DOTFILES_USR_SHARE="$DOTFILES_HOME/usr/share"

# $HOME
cp $DOTFILES_HOME/.asoundrc ~/
cp $DOTFILES_HOME/.profile ~/
cp $DOTFILES_HOME/.TilingAssistantExtension.layouts.json ~/
cp $DOTFILES_HOME/.ssh/config ~/.ssh/

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{alacritty,Code/User,dash-to-panel,flameshot,git,gnome-extensions-sync,htop,i3,i3blocks,mpv,pulse,sublime-text-3/Packages/User,tmux,vim,zsh}
cp $DOTFILES_CONFIG_HOME/.config/aliasrc ~/.config
cp $DOTFILES_CONFIG_HOME/.config/alacritty/alacritty.yml ~/.config/alacritty/
cp $DOTFILES_CONFIG_HOME/.config/Code/User/{keybindings.json,settings.json} ~/.config/Code/User/
cp $DOTFILES_CONFIG_HOME/.config/dash-to-panel/dash-to-panel-settings ~/.config/dash-to-panel/
cp $DOTFILES_CONFIG_HOME/.config/flameshot/flameshot.conf ~/.config/flameshot/
cp $DOTFILES_CONFIG_HOME/.config/git/config ~/.config/git/
cp $DOTFILES_CONFIG_HOME/.config/gnome-extensions-sync/extensions.json ~/.config/gnome-extensions-sync/
cp $DOTFILES_CONFIG_HOME/.config/htop/htoprc ~/.config/htop/
cp $DOTFILES_CONFIG_HOME/.config/i3/config ~/.config/i3/
cp $DOTFILES_CONFIG_HOME/.config/i3blocks/config ~/.config/i3blocks/
cp $DOTFILES_CONFIG_HOME/.config/mpv/mpv.conf ~/.config/mpv/
cp $DOTFILES_CONFIG_HOME/.config/pulse/daemon.conf ~/.config/pulse/
cp $DOTFILES_CONFIG_HOME/.config/sublime-text-3/Packages/User/{"Default (Linux).sublime-keymap","Package Control.sublime-settings",Preferences.sublime-settings} ~/.config/sublime-text-3/Packages/User/
cp .config/tmux/tmux.conf ~/.config/tmux/
cp .config/vim/vimrc ~/.config/vim/
cp .config/zsh/.{p10k.zsh,zshrc} ~/.config/zsh/

# $HOME/.local/bin
# mkdir -p ~/.local/bin
# cp .local/bin/{countdown,extramaus,fix-volume,mute-spotify-ads} ~/.local/bin/
