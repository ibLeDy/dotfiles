export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="false"
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=10000
SAVEHIST=10000
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE="true"

plugins=(
    git
    colorize
    colored-man-pages
    compleat
    safe-paste
    virtualenvwrapper
    # zsh-autosuggestions
    # zsh-completions
    # zsh-syntax-highlighting
)

# Reload the completion for `zsh-completions`
# autoload -U compinit && compinit

# Accept current suggestion with `ctrl + space`
# bindkey '^ ' autosuggest-accept

source $ZSH/oh-my-zsh.sh

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
