# tmux
alias ta='tmux attach'
alias tl='tmux list-session'
alias tn='tmux new -s $(pwd | sed -e "s,^$HOME\/,,")'

# git
alias gb='git branch'
alias gco='git checkout'
alias gr='git rebase'
alias gc='git commit --verbose'

# eza
if (type conda >/dev/null 2>&1); then
    alias eza="eza --icons -s ext"
    alias ll="eza -hl"
    alias la="ll -a"
    alias lt="ll -T -L 1 $(pwd)"
    alias lt2="ll -T -L 2 $(pwd)"
    alias lt3="ll -T -L 2 $(pwd)"
fi
