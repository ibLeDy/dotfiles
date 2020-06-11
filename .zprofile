#!/bin/zsh

# Default programs:
export EDITOR="subl"
export TERMINAL="alacritty"
export BROWSER="brave-browser"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export VIMINIT='source "$XDG_CONFIG_HOME/vim/vimrc"'
# export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
# export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
# export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
# export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
