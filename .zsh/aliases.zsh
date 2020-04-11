
typeset -A alias_lst

alias_lst=(
    "n" "nvim"
    "vi" "nvim"
    "ls" "exa --icons"
    "ll" "exa --icons --long"
)

for al in ${(k)alias_lst}; do
  alias $al="${alias_lst[$al]}"
done

alias -s {py,js,vue}=vim
alias -g G='| rg -i'
alias -g F='| fzf'
