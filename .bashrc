# Common aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gc='git commit -v'
alias glg='git log --stat'

# Use neovim for vim if present.
[ -x "$(command -v nvim)" ] && alias vim="nvim"

# Default programs:
export EDITOR="subl"
export TERMINAL="alacritty"
export BROWSER="google-chrome"

# Verbosity
alias \
    cp="cp -iv" \
    mv="mv -iv" \
    rm="rm -Iv"

# Colorize commands when possible.
alias \
    ls="ls -hN --color=auto --group-directories-first" \
    grep="grep --color=auto" \
    diff="diff --color=auto"
