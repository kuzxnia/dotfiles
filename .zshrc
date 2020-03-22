autoload -U compinit; compinit

setopt interactivecomments # Allow comments after commands
setopt autocd              # cd to directories without typing cd
setopt extendedglob        # Expand file expressiong (e.g. **/file)
setopt no_beep             # No bells

export PATH=$HOME/bin:$PATH
export PATH="/home/kuznia/.pyenv/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
    zsh-history-substring-search
    fast-syntax-highlighting
    vi-mode
    sudo
)

source $ZSH/oh-my-zsh.sh
source "$HOME/.zsh/abbreviations.zsh"

export LANG=en_US.UTF-8
export EDITOR='nvim'

bindkey '^ ' autosuggest-accept
bindkey "^K" up-line-or-search
bindkey "^J" down-line-or-search

eval "$(jump shell)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(pipenv --completion)"

alias ls="exa --icons"
alias ll="exa --long"

alias -s {py,js,vue}=vim
alias -g G='| rg -i'
alias -g F='| fzf'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS=" --color=dark --reverse --border"
[ -f ~/.dotfiles/plugins/.forgit.plugin.zsh ] && source ~/.dotfiles/plugins/.forgit.plugin.zsh
