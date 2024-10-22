#!/usr/bin/env bash

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"

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
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
# export PYTHONPATH="$HOME/.local/lib/python3.8:$PYTHONPATH"
export VIRTUALENVWRAPPER_PYTHON=$(command -v python3)
# . "$HOME/.local/bin/virtualenvwrapper.sh"

# Rust
# export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
if [ -f "$HOME/.cargo/env" ] ; then
    . "$HOME/.cargo/env"
fi

# Ruby
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# Go
# export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

# Default programs:
export VISUAL="vim"
export TERMINAL="alacritty"
export BROWSER="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# Create zsh's cache folder if not present
if ! [ -d "$HOME/.cache/zsh" ] ; then
    mkdir "$HOME/.cache/zsh"
fi

# Set formatting for `time` command
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

# Qt theme
export QT_QPA_PLATFORMTHEME=qt5ct

# Set Starship config path
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=true
