#!/bin/bash
mkdir -p ~/.cache/zsh
mkdir -p ~/.config/{alacritty,Code/User,dash-to-panel,flameshot,git,htop,i3,i3blocks,mpv,pulse,sublime-text-3/Packages/User,tmux,vim,zsh}
cp .config/alacritty/alacritty.yml ~/.config/alacritty/
cp .config/Code/User/{keybindings.json,settings.json} ~/.config/Code/User/
cp .config/dash-to-panel/dash-to-panel-settings ~/.config/dash-to-panel/
cp .config/flameshot/flameshot.conf ~/.config/flameshot/
cp .config/git/config ~/.config/git/
cp .config/htop/htoprc ~/.config/htop/
cp .config/i3/config ~/.config/i3/
cp .config/i3blocks/config ~/.config/i3blocks/
cp .config/mpv/mpv.conf ~/.config/mpv/
cp .config/pulse/daemon.conf ~/.config/pulse/
cp .config/sublime-text-3/Packages/User/{"Default (Linux).sublime-keymap","Package Control.sublime-settings",Preferences.sublime-settings} ~/.config/sublime-text-3/Packages/User/
cp .config/tmux/tmux.conf ~/.config/tmux/
cp .config/vim/vimrc ~/.config/vim/
cp .config/zsh/.{p10k.zsh,zshrc} ~/.config/zsh/
sudo cp etc/asound.conf /etc/
sudo cp etc/default/grub /etc/default/
# cp .local/bin/{countdown,extramaus,fix-volume,mute-spotify-ads} ~/.local/bin/
cp .profile ~/
cp .ssh/config ~/.ssh/
