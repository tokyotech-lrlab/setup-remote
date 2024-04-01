# tmux
alias ta='tmux attach'
alias tl='tmux list-session'
alias tn='tmux new'

# exa
if (type exa >/dev/null 2>&1); then
    alias exa="exa --icons -s ext"
    alias ll='exa -hl'
    alias lt='ll -T -L 1'
    alias lt2='ll -T -L 2'
    alias lt3='ll -T -L 3'

    # ls after cd
    cdls() {
        \cd "$@" && lt $(pwd)
    }
    alias cd="cdls"
else
    # ls after cd
    cdls() {
        \cd "$@" && ll $(pwd)
    }
fi

alias cd="cdls"
