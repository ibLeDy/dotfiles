#!/bin/bash
mkdir -p .config/{alacritty,Code/User,dash-to-panel,flameshot,git,gnome-extensions-sync,htop,i3,i3blocks,mpv,pulse,sublime-text-3/Packages/User,tmux,vim,zsh}
mkdir -p .local/bin
mkdir -p .ssh
mkdir -p etc/{X11,default}

cp ~/.config/alacritty/alacritty.yml .config/alacritty/
cp ~/.config/Code/User/{keybindings.json,settings.json} .config/Code/User/
cp ~/.config/dash-to-panel/dash-to-panel-settings .config/dash-to-panel/
cp ~/.config/flameshot/flameshot.conf .config/flameshot/
cp ~/.config/git/config .config/git/
cp ~/.config/gnome-extensions-sync/extensions.json .config/gnome-extensions-sync
cp ~/.config/htop/htoprc .config/htop/
cp ~/.config/i3/config .config/i3/
cp ~/.config/i3blocks/config .config/i3blocks/
cp ~/.config/mpv/mpv.conf .config/mpv/
cp ~/.config/pulse/daemon.conf .config/pulse/
cp ~/.config/sublime-text-3/Packages/User/{"Default (Linux).sublime-keymap","Package Control.sublime-settings",Preferences.sublime-settings} .config/sublime-text-3/Packages/User/
# cp ~/.config/tmux/tmux.conf .config/tmux/
cp ~/.config/vim/vimrc .config/vim/
cp ~/.config/zsh/.{p10k.zsh,zshrc} .config/zsh/
# cp ~/.local/bin/{countdown,extramaus,fix-volume,mute-spotify-ads} .local/bin/
cp ~/.profile .
cp ~/.TilingAssistantExtension.layouts.json .
cp ~/.tmux.conf .
cp ~/.ssh/config .ssh/

sudo cp etc/asound.conf /etc/
sudo cp /etc/X11/xorg.conf /etc/X11/
sudo cp etc/default/grub /etc/default/