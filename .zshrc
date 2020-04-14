zmodload zsh/zprof

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

setopt interactivecomments # Allow comments after commands
setopt no_beep             # No bells

export PATH=$HOME/bin:$PATH
export PATH="/home/kuznia/.pyenv/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --hidden'


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
EDITOR='nvim'

FZF_DEFAULT_OPTS=" --color=dark --reverse --border"

bindkey '^ ' autosuggest-accept
bindkey "^K" up-line-or-search
bindkey "^J" down-line-or-search

eval "$(jump shell)"
eval "$(hub alias -s)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.dotfiles/plugins/.forgit.plugin.zsh ] && source ~/.dotfiles/plugins/.forgit.plugin.zsh
