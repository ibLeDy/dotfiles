# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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
export PYTHONPATH="$HOME/.local/lib/python3.7:$PYTHONPATH"
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source "$HOME/.local/bin/virtualenvwrapper.sh"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
# export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

# Ruby
export PATH="$HOME/gems/bin:$PATH"
export GEM_HOME="$HOME/gems"

# Go
# export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

# Default programs:
export EDITOR="subl"
export TERMINAL="alacritty"
export BROWSER="brave-browser"
