export PATH=$HOME/bin:$PATH
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    vi-mode
)

autoload -U compinit
compinit

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

eval "$(jump shell)"

alias rs='ranger'

alias ls='ls --color=tty'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias -s {py,js,vue}=vim
alias -g G='| grep -i'


# ga - forgit
alias gaa='git add -A'
alias gap='git add -p'

alias vst='git vist'
alias gst='git st'

alias gb='git branch'
alias gbb='git bb'

alias gco='git fco'
alias gcob='git co -b'
alias gbd='git fbd'

alias gpc='git pc'
alias grb='git rb'
alias gmb='git mb'

# glo - forgit

alias gcm='git commit -m'
alias gp='git push origin'
alias gfa='git fetch -av'

alias gh='git stash'
alias ghl='git stash list'
alias ghp='git stash pop'
alias ghs='git stash save'
alias ghsp='git stash save --patch'
alias ghw='git stash show -p'

alias gmt='git mergetool'

alias gs='git show -p'
alias gup='git up'

alias l="ls -lh"
alias ll="l -a"
alias lt='ls -lt'
alias ltr='ls -ltr'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS=" --border --reverse "
[ -f ~/.dotfiles/plugins/.forgit.plugin.zsh ] && source ~/.dotfiles/plugins/.forgit.plugin.zsh
