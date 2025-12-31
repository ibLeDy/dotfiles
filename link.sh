#!/usr/bin/env bash

link_file() {
    if [ -L "$2" ] && [ -e "$2" ] # it is a symlink and destination file exists
    then
        true
    elif [ -L "$2" ] && [ ! -e "$2" ] # it is a symlink but destination file doesn't exist
    then
        echo "$2 is broken, fixing..."
        ln -s -f "$1" "$2"
    else
        ln -s "$1" "$2"
    fi
}

DOTFILES_HOME=$(dirname -- "$(readlink -f -- "$0")")
DOTFILES_CONFIG_HOME=$DOTFILES_HOME/.config
DOTFILES_LOCAL_BIN=$DOTFILES_HOME/.local/bin

# $HOME
mkdir -p ~/.cache
link_file "$DOTFILES_HOME"/.asoundrc ~/.asoundrc
link_file "$DOTFILES_HOME"/.bashrc ~/.bashrc
link_file "$DOTFILES_HOME"/.imwheelrc ~/.imwheelrc
link_file "$DOTFILES_HOME"/.pdbrc ~/.pdbrc
link_file "$DOTFILES_HOME"/.profile ~/.profile
link_file "$DOTFILES_HOME"/.profile ~/.zprofile

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{alacritty,Code/User,dash-to-panel,flameshot,ghostty,git/{config.d,templates/hooks},gnome-extensions-sync,htop,i3,i3blocks,lsd,mpv,nano,oh-my-posh,pulse,spaceship,starship,sublime-text/Packages/User,tmux,tiling-assistant,vim,zsh}
link_file "$DOTFILES_CONFIG_HOME"/aliasrc ~/.config/aliasrc
link_file "$DOTFILES_CONFIG_HOME"/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
link_file "$DOTFILES_CONFIG_HOME"/Code/User/keybindings.json ~/.config/Code/User/keybindings.json
link_file "$DOTFILES_CONFIG_HOME"/Code/User/settings.json ~/.config/Code/User/settings.json
link_file "$DOTFILES_CONFIG_HOME"/dash-to-panel/dash-to-panel-settings ~/.config/dash-to-panel/dash-to-panel-settings
link_file "$DOTFILES_CONFIG_HOME"/flameshot/flameshot.conf ~/.config/flameshot/flameshot.conf
link_file "$DOTFILES_CONFIG_HOME"/ghostty/config ~/.config/ghostty/config
link_file "$DOTFILES_CONFIG_HOME"/git/config ~/.config/git/config
link_file "$DOTFILES_CONFIG_HOME"/git/ignore ~/.config/git/ignore
link_file "$DOTFILES_CONFIG_HOME"/git/config.d/personal ~/.config/git/config.d/personal
link_file "$DOTFILES_CONFIG_HOME"/git/config.d/work ~/.config/git/config.d/work
link_file "$DOTFILES_CONFIG_HOME"/git/templates/hooks/pre-commit ~/.config/git/templates/hooks/pre-commit
link_file "$DOTFILES_CONFIG_HOME"/gnome-extensions-sync/extensions.json ~/.config/gnome-extensions-sync/extensions.json
link_file "$DOTFILES_CONFIG_HOME"/htop/htoprc ~/.config/htop/htoprc
link_file "$DOTFILES_CONFIG_HOME"/i3/config ~/.config/i3/config
link_file "$DOTFILES_CONFIG_HOME"/i3blocks/config ~/.config/i3blocks/config
link_file "$DOTFILES_CONFIG_HOME"/lsd/config.yaml ~/.config/lsd/config.yaml
link_file "$DOTFILES_CONFIG_HOME"/mpv/mpv.conf ~/.config/mpv/mpv.conf
link_file "$DOTFILES_CONFIG_HOME"/nano/nanorc ~/.config/nano/nanorc
link_file "$DOTFILES_CONFIG_HOME"/oh-my-posh/theme.omp.json ~/.config/oh-my-posh/theme.omp.json
link_file "$DOTFILES_CONFIG_HOME"/pulse/default.pa ~/.config/pulse/default.pa
link_file "$DOTFILES_CONFIG_HOME"/pulse/daemon.conf ~/.config/pulse/daemon.conf
link_file "$DOTFILES_CONFIG_HOME"/spaceship/spaceship.zsh ~/.config/spaceship/spaceship.zsh
link_file "$DOTFILES_CONFIG_HOME"/starship/starship.toml ~/.config/starship/starship.toml
link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/Default\ \(Linux\).sublime-keymap ~/.config/sublime-text/Packages/User/Default\ \(Linux\).sublime-keymap
link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/Default\ \(Linux\).sublime-mousemap ~/.config/sublime-text/Packages/User/Default\ \(Linux\).sublime-mousemap
link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/Package\ Control.sublime-settings ~/.config/sublime-text/Packages/User/Package\ Control.sublime-settings
link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/Preferences.sublime-settings ~/.config/sublime-text/Packages/User/Preferences.sublime-settings
link_file "$DOTFILES_CONFIG_HOME"/tmux/tmux.conf ~/.config/tmux/tmux.conf
link_file "$DOTFILES_CONFIG_HOME"/tiling-assistant/layouts.json ~/.config/tiling-assistant/layouts.json
link_file "$DOTFILES_CONFIG_HOME"/vim/vimrc ~/.config/vim/vimrc
link_file "$DOTFILES_CONFIG_HOME"/zsh/.p10k.zsh ~/.config/zsh/.p10k.zsh
link_file "$DOTFILES_CONFIG_HOME"/zsh/.zshrc ~/.config/zsh/.zshrc

# $HOME/.local/bin
mkdir -p ~/.local/bin
link_file "$DOTFILES_LOCAL_BIN"/countdown ~/.local/bin/countdown
link_file "$DOTFILES_LOCAL_BIN"/extramaus ~/.local/bin/extramaus
link_file "$DOTFILES_LOCAL_BIN"/mute-spotify-ads ~/.local/bin/mute-spotify-ads
link_file "$DOTFILES_LOCAL_BIN"/screenshare ~/.local/bin/screenshare
link_file "$DOTFILES_LOCAL_BIN"/set-mouse-speed ~/.local/bin/set-mouse-speed
link_file "$DOTFILES_LOCAL_BIN"/get-scaling-governor ~/.local/bin/get-scaling-governor
link_file "$DOTFILES_LOCAL_BIN"/set-scaling-governor ~/.local/bin/set-scaling-governor
link_file "$DOTFILES_LOCAL_BIN"/update-current-branch ~/.local/bin/update-current-branch
link_file "$DOTFILES_LOCAL_BIN"/delete-merged-branch ~/.local/bin/delete-merged-branch
link_file "$DOTFILES_LOCAL_BIN"/wakeup-workaround ~/.local/bin/wakeup-workaround
link_file "$DOTFILES_LOCAL_BIN"/fix-caret ~/.local/bin/fix-caret

# $HOME/.ssh
mkdir -p ~/.ssh
link_file "$DOTFILES_HOME"/.ssh/config ~/.ssh/config
