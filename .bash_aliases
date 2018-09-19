# Modify default prompt
# Fontground: \e[38;5;COLOR_CODEm
# Bold: \e[1m 
# Reset: \e[0m
PS1="[\u@\h \e[1m\e[38;5;245m\w\e[0m]\\n[\e[1m\e[38;5;172m\!\e[0m] \e[1m\\$\e[0m "

# Change environment variables
PATH="~/Utils/scripts:~/Utils/bins:${PATH}"
PATH="~/Utils/vim/bin:${PATH}"
export LD_LIBRARY_PATH="/home/yuliang.tao/Utils/libs/:$LD_LIBRARY_PATH"

# custom functions
function cdls() { cd "$*" && ls; }
function createtar(){ tar -cvf  "${1%%/}.tar"     "${1%%/}/"; }
function createtgz(){ tar -cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
function createtbz(){ tar -cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
function extractfile(){
    if [ -f $1 ]; then
         case $1 in
             *.tar.bz2)   tar -xjf $1                                   ;;
             *.tar.gz)    tar -xzf $1                                   ;;
             *.bz2)       bunzip2 $1                                    ;;
             *.gz)        gunzip $1                                     ;;
             *.tar)       tar -xf $1                                    ;;
             *.tbz2)      tar -xjvf $1                                  ;;
             *.tgz)       tar -xzvf $1                                  ;;
             *.zip)       unzip $1                                      ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
    else
         echo "'$1' is not a valid file"
fi
}

function fixperm_recur() {
  if [ -d $1 ]; then
    find $1 -type d -exec chmod 755 {} \;
    find $1 -type f -exec chmod 644 {} \;
  else
    echo "$1 is not a directory."
  fi
}

# aliases
alias h='history'
alias tmux='tmux -2'
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'

alias grep='grep -rnE --color'
alias pgrep='grep -rnP --color'

alias du0="du -h --max-depth=0"
alias du1="du -h --max-depth=1"

alias lsd='find . -maxdepth 1 -type d | sort'
alias dfind='find -type d -name'
alias ffind='find -type f -name'

alias cd="cdls"
alias mktar="createtar"
alias mktgz="createtgz"
alias mktbz="createtbz"
alias extract="extractfile"
alias fixperm="fixperm_recur"

alias myrc="vim ~/.mybashrc && source ~/.mybashrc"
alias reload="source ~/.bashrc"
