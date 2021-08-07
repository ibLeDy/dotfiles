# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# gnome-keyring
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

export GPG_TTY=$(tty)
# export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
# export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"

# Python
# export PYTHONPATH="$HOME/.local/lib/python3.8:$PYTHONPATH"
export VIRTUALENVWRAPPER_PYTHON="$(which python3)"
# source "$HOME/.local/bin/virtualenvwrapper.sh"

# Rust
source "$HOME/.cargo/env"
# export PATH="$HOME/.cargo/bin:$PATH"
# export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

# Ruby
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# Go
# export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

# Default programs:
export VISUAL="vim"
export TERMINAL="alacritty"
export BROWSER="google-chrome"

# Fix screen tearing
# if [ -f "$HOME/.local/bin/fix-screen-tearing" ]; then
#     sh -c "$HOME/.local/bin/fix-screen-tearing"
# fi

# Create zsh's cache folder if not present
if ! [ -d "$HOME/.cache/zsh" ] ; then
    mkdir "$HOME/.cache/zsh"
fi

# Set formatting for `time` command
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

# Execute imwheel if present
# if [ -f "$HOME/.imwheelrc" ]; then
#     [ -x "$(command -v imwheel)" ] && imwheel --kill --buttons="4 5" > /dev/null 2>&1
# fi

# Qt theme
export QT_QPA_PLATFORMTHEME=qt5ct
