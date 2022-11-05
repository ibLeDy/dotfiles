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

# SSH Stuff
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

add_keys (){
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_ed25519
    ssh-add ~/.ssh/id_ed25519-pi
}

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    add_keys
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    add_keys
fi

unset env
