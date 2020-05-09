export ZSH="/home/bledy/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_COLORIZE_STYLE="colorful"
COMPLETION_WAITING_DOTS="false"
HIST_STAMPS="mm/dd/yyyy"
# ENABLE_CORRECTION="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

export ZSH="/home/bledy/.oh-my-zsh"

plugins=(
    compleat
    rand-quote
    safe-paste
    zsh-completions
    colored-man-pages
    virtualenvwrapper
)

alias ytdl='youtube-dl --merge-output-format mkv'
alias open='xdg-open'
alias gc='git commit -v'
alias gss='git status -s'
alias lbrynet='/opt/LBRY/resources/static/daemon/lbrynet'

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.cargo/bin:$PATH"
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
