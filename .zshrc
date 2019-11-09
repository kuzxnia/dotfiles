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
    virtualenvwrapper
)

autoload -U compinit
compinit

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

alias ls='ls --color=tty'
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias -s {py,js,vue}=vim
alias -g G='| grep -i'


alias ga='git add'
alias gap='git add -p'

alias gst='git st'

alias gb='git branch'
alias gbb='git bb'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gcd='git checkout development && git pull origin development'
alias grbd='git pull origin development && git rebase development'
alias gcs='git checkout staging && git pull origin staging'
alias grbs='git pull origin staging && git rebase staging'

alias gcm='git commit -m'
alias gp='git push origin'
alias gfa='git fetch -av'

alias gh='git stash'
alias ghl='git stash list'
alias ghp='git stash pop'
alias ghs='git stash save'
alias ghsp='git stash save --patch'
alias ghw='git stash show -p'

alias gl='git l -20'
alias gll='git ll -20'

alias gm='git merge'
alias gmt='git mergetool'

alias gs='git show -p'
alias gup='git up'

alias l="ls -lh"
alias ll="l -a"
alias lt='ls -lt'
alias ltr='ls -ltr'

 [-f ~/.fzf.zsh ] && source ~/.fzf.zsh
