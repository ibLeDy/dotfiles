export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="false"
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=10000
SAVEHIST=10000
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE="true"
ZSH_HIGHLIGHT_MAXLENGTH=300

plugins=(
    docker
    docker-compose
    git
    colorize
    colored-man-pages
    compleat
    kubectl
    safe-paste
    virtualenvwrapper
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

# Reload tab completion
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# Accept current suggestion with ctrl + space
bindkey '^ ' autosuggest-accept

# Don't cd to directory of same name as a non-found executable
unsetopt AUTO_CD

# Load powerlevel10k config
[[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh" ]] || source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh"

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"

# Load alacritty's shell completions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Open current command in editor
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
