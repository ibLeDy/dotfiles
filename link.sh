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
link_file "$DOTFILES_HOME"/.bashrc ~/.bashrc
link_file "$DOTFILES_HOME"/.pdbrc ~/.pdbrc
link_file "$DOTFILES_HOME"/.profile ~/.profile

# $XDG_CONFIG_HOME
mkdir -p ~/.config/{alacritty,flameshot,git/{config.d,templates/hooks},htop,lsd,oh-my-posh,starship,tmux,vim,zellij/{layouts,plugins},zsh}
mkdir -p ~/Library/'Application Support'/Code/User
mkdir -p ~/Library/'Application Support'/'Sublime Text'/Packages/User
link_file "$DOTFILES_CONFIG_HOME"/aliasrc ~/.config/aliasrc
link_file "$DOTFILES_CONFIG_HOME"/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
link_file "$DOTFILES_CONFIG_HOME"/Code/User/keybindings.json ~/Library/'Application Support'/Code/User/keybindings.json
link_file "$DOTFILES_CONFIG_HOME"/Code/User/settings.json ~/Library/'Application Support'/Code/User/settings.json
# link_file "$DOTFILES_CONFIG_HOME"/flameshot/flameshot.conf ~/.config/flameshot/flameshot.conf
link_file "$DOTFILES_CONFIG_HOME"/git/config ~/.config/git/config
link_file "$DOTFILES_CONFIG_HOME"/git/ignore ~/.config/git/ignore
link_file "$DOTFILES_CONFIG_HOME"/git/config.d/personal ~/.config/git/config.d/personal
link_file "$DOTFILES_CONFIG_HOME"/git/config.d/work ~/.config/git/config.d/work
link_file "$DOTFILES_CONFIG_HOME"/git/templates/hooks/pre-commit ~/.config/git/templates/hooks/pre-commit
# link_file "$DOTFILES_CONFIG_HOME"/htop/htoprc ~/.config/htop/htoprc
link_file "$DOTFILES_CONFIG_HOME"/lsd/config.yaml ~/.config/lsd/config.yaml
link_file "$DOTFILES_CONFIG_HOME"/oh-my-posh/theme.omp.json ~/.config/oh-my-posh/theme.omp.json
link_file "$DOTFILES_CONFIG_HOME"/starship/starship.toml ~/.config/starship/starship.toml
link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/'Default (OSX).sublime-keymap' ~/Library/'Application Support'/'Sublime Text'/Packages/User/'Default (Linux).sublime-keymap'
link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/'Package Control.sublime-settings' ~/Library/'Application Support'/'Sublime Text'/Packages/User/'Package Control.sublime-settings'
link_file "$DOTFILES_CONFIG_HOME"/sublime-text/Packages/User/Preferences.sublime-settings ~/Library/'Application Support'/'Sublime Text'/Packages/User/Preferences.sublime-settings
link_file "$DOTFILES_CONFIG_HOME"/tmux/tmux.conf ~/.config/tmux/tmux.conf
link_file "$DOTFILES_CONFIG_HOME"/vim/vimrc ~/.config/vim/vimrc
link_file "$DOTFILES_CONFIG_HOME"/zellij/config.kdl ~/.config/zellij/config.kdl
link_file "$DOTFILES_CONFIG_HOME"/zellij/layouts/default.kdl ~/.config/zellij/layouts/default.kdl
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
