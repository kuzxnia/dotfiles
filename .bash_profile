#!/bin/bash

export PATH=$HOME/bin:$PATH

alias sAg='sudo apt-get install'
alias Ai='apt-cache show'
alias sAr='sudo apt-get remove'

alias g='git'

alias ga='git add'
alias gap='git add -p'

alias gst='git st'

alias gb='git branch'
alias gbb='git bb'

alias gco='git checkout'

alias gcd='git checkout development && git pull origin development'
alias grbd='git pull origin development && git rebase development'
alias gcs='git checkout staging && git pull origin staging'
alias grbs='git pull origin staging && git rebase staging'

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

. ~/.bashrc  # for tmux
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '
