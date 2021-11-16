# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zmodload zsh/zprof

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

setopt interactivecomments # Allow comments after commands
setopt no_beep             # No bells
unsetopt autocd

export PATH=$HOME/bin:$PATH
export PATH="$HOME/.pyenv/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --hidden'

export TERMINAL=kitty
# export MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')
export BROWSER="google-chrome"
export EDITOR="nvim"
export VISUAL="nvim"

# load plugins
source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", from:github, defer:0

# oh-my-zsh stuff
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", defer:3
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
# theme
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
SPACESHIP_PROMPT_ADD_NEWLINE="false"
# zplug "romkatv/powerlevel10k", as:theme, depth:1

# completion and syntax
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:3


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

source "$HOME/.zsh/abbreviations.zsh"
source "$HOME/.zsh/aliases.zsh"
source "$HOME/.zplug/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"
source <(navi widget zsh)

# oh-my-zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
DISABLE_AUTO_TITLE="true"

LANG=en_US.UTF-8

FZF_DEFAULT_OPTS=" --color=dark --reverse --border"

bindkey '^ ' autosuggest-accept
bindkey "^K" up-line-or-search
bindkey "^J" down-line-or-search

eval "$(jump shell)"
eval "$(hub alias -s)"
eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.dotfiles/plugins/.forgit.plugin.zsh ] && source ~/.dotfiles/plugins/.forgit.plugin.zsh

nvm() {
  echo "🚨 NVM not loaded! Loading now..."
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm "$@"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH=$HOME/.config/nvcode/utils/bin:$PATH
export PATH="$HOME/.poetry/bin:$PATH"
