#!/usr/bin/env bash

link_file() {
    if [ -L "$2" ] && [ -e "$2" ]
    then
        true
    elif [ -f "$2" ] && [ ! -e "$2" ]
    then
        echo "$2 is broken"
    else
        ln -s $1 $2
    fi
}

DOTFILES_HOME=$(dirname -- "$(readlink -f -- "$0")")
DOTFILES_CONFIG_HOME=$DOTFILES_HOME/.config
DOTFILES_LOCAL_BIN=$DOTFILES_HOME/.local/bin
DOTFILES_LOCAL_SHARE=$DOTFILES_HOME/.local/share

# $HOME
mkdir -p ~/.cache
link_file "$DOTFILES_HOME"/.bashrc ~/.bashrc
link_file "$DOTFILES_HOME"/.pdbrc ~/.pdbrc
link_file "$DOTFILES_HOME"/.profile ~/.profile

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{alacritty,flameshot,git/{config.d,templates/hooks},htop,lsd,starship,tmux,vim,zellij,zsh}
mkdir -p ~/Library/Application\ Support/Code/User/
# mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
link_file "$DOTFILES_CONFIG_HOME"/aliasrc ~/.config/aliasrc
link_file "$DOTFILES_CONFIG_HOME"/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
link_file "$DOTFILES_CONFIG_HOME"/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
link_file "$DOTFILES_CONFIG_HOME"/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
# link_file "$DOTFILES_CONFIG_HOME"/flameshot/flameshot.conf ~/.config/flameshot/flameshot.conf
link_file "$DOTFILES_CONFIG_HOME"/git/config ~/.config/git/config
link_file "$DOTFILES_CONFIG_HOME"/git/ignore ~/.config/git/ignore
link_file "$DOTFILES_CONFIG_HOME"/git/config.d/personal ~/.config/git/config.d/personal
link_file "$DOTFILES_CONFIG_HOME"/git/config.d/work ~/.config/git/config.d/work
link_file "$DOTFILES_CONFIG_HOME"/git/templates/hooks/pre-commit ~/.config/git/templates/hooks/pre-commit
# link_file "$DOTFILES_CONFIG_HOME"/htop/htoprc ~/.config/htop/htoprc
link_file "$DOTFILES_CONFIG_HOME"/lsd/config.yaml ~/.config/lsd/config.yaml
link_file "$DOTFILES_CONFIG_HOME"/mpv/mpv.conf ~/.config/mpv/mpv.conf
link_file "$DOTFILES_CONFIG_HOME"/starship/starship.toml ~/.config/starship/starship.toml
# cp $DOTFILES_CONFIG_HOME/sublime-text/Packages/User/{'Default (OSX).sublime-keymap',Preferences.sublime-settings} ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
# link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/'Default (Linux).sublime-keymap' ~/.config/sublime-text/Packages/User/'Default (Linux).sublime-keymap'
# link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/'Default (Linux).sublime-mousemap' ~/.config/sublime-text/Packages/User/'Default (Linux).sublime-mousemap'
# link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/'Package Control.sublime-settings' ~/.config/sublime-text/Packages/User/'Package Control.sublime-settings'
# link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/Preferences.sublime-settings ~/.config/sublime-text/Packages/User/Preferences.sublime-settings
link_file "$DOTFILES_CONFIG_HOME"/tmux/tmux.conf ~/.config/tmux/tmux.conf
link_file "$DOTFILES_CONFIG_HOME"/vim/vimrc ~/.config/vim/vimrc
link_file "$DOTFILES_CONFIG_HOME"/zellij/config.yaml ~/.config/zellij/config.yaml
link_file "$DOTFILES_CONFIG_HOME"/zsh/.p10k.zsh ~/.config/zsh/.p10k.zsh
link_file "$DOTFILES_CONFIG_HOME"/zsh/.zshrc ~/.config/zsh/.zshrc

# $HOME/.local/bin
mkdir -p ~/.local/bin
link_file "$DOTFILES_LOCAL_BIN"/countdown ~/.local/bin/countdown
link_file "$DOTFILES_LOCAL_BIN"/update-current-branch ~/.local/bin/update-current-branch
link_file "$DOTFILES_LOCAL_BIN"/delete-merged-branch ~/.local/bin/delete-merged-branch

# $HOME/.gnupg
mkdir -p ~/.gnupg
cp "$DOTFILES_HOME"/.gnupg/gpg-agent.conf ~/.gnupg

# $HOME/.ssh
mkdir -p ~/.ssh
link_file "$DOTFILES_HOME"/.ssh/config ~/.ssh/config

# $HOME/.local/share
mkdir -p ~/.local/share/zellij/{layouts,plugins}
link_file "$DOTFILES_LOCAL_SHARE"/zellij/layouts/default.yaml ~/.local/share/zellij/layouts/default.yaml
link_file "$DOTFILES_LOCAL_SHARE"/zellij/layouts/strider.yaml ~/.local/share/zellij/layouts/strider.yaml
cp "$DOTFILES_LOCAL_SHARE"/zellij/plugins/{status-bar,strider,tab-bar}.wasm ~/.local/share/zellij/plugins/
