alias h='history'
alias tmux='tmux -2'
alias ll='ls -alF'

function cdls() { cd "$*" && ls; }
alias cd="cdls"
