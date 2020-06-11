export ZSH="/home/bledy/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="false"
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CACHE_HOME/zsh/history

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    compleat
    rand-quote
    safe-paste
    zsh-completions
    colored-man-pages
    virtualenvwrapper
)

source $ZSH/oh-my-zsh.sh

# Load powerlevel10k config
[[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh" ]] || source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh"

# Load aliases if existent
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
