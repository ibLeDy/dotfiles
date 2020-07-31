export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="false"
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=10000
SAVEHIST=10000
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    colorize
    colored-man-pages
    compleat
    safe-paste
    virtualenvwrapper
    # zsh-autosuggestions
    zsh-completions
    # zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Load powerlevel10k config
[[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh" ]] || source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.p10k.zsh"

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
