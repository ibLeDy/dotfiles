# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Environment variables
export EDITOR="$HOME/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
export VISUAL="vim"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PIP_REQUIRE_VIRTUALENV=true
export ANSIBLE_NOCOWS=1

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="false"
HISTFILE="$XDG_CACHE_HOME/zsh/history"  # TODO: remove
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=10000
SAVEHIST=10000
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE="true"
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

plugins=(
    docker
    docker-compose
    git
    git-flow-completion
    colorize
    colored-man-pages
    compleat
    kubectl
    minikube
    safe-paste
    vagrant
    virtualenvwrapper
    #zsh-autosuggestions
    #zsh-completions
    #zsh-syntax-highlighting
)

# Reload tab completion
autoload -U compinit && compinit

# Load OMZ
source $ZSH/oh-my-zsh.sh

# Accept current suggestion with ctrl + space
#bindkey '^ ' autosuggest-accept

# Don't cd to directory of same name as a non-found executable
unsetopt AUTO_CD

# Don't auto insert possibilities
unsetopt AUTO_MENU

# Open current command in $VISUAL
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Use fzf for history
__fzfcmd() {
    echo "fzf"
}

# ctrl+r - Paste the selected command from history into the command line
fzf-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail HIST_FIND_NO_DUPS 2> /dev/null

    selected=( $(fc -rl 1 |
      FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected" ]; then
      num=$selected[1]
      if [ -n "$num" ]; then
        zle vi-fetch-history -n $num
      fi
    fi
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

# Enable stacking for docker's tab completion
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

fssh() {
    SRV=$(cat $HOME/.ssh/config | grep -E "Host [^*]" | awk '{ print $2 }' | sort | fzf --height 30%)
    echo "$SRV"
    tmux rename-window "$SRV"
    command ssh "$@" "$SRV"
    tmux rename-window "zsh"
}

tssh() {
    tmux rename-window "$*"
    command ssh "$@"
    tmux rename-window "zsh"
}

vgssh() {
    tmux rename-window "vagrant-$*"
    command vagrant ssh "$@"
    tmux rename-window "zsh"
}

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Pyenv
# eval "$(pyenv init -)"

source "$HOME/.cargo/env"

export GPG_TTY=$(tty)

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Load aliases if existent
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
