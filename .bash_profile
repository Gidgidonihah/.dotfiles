# Source local bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

PS1='\[\033[1;34m\]\t\[\033[0;36m\]|\h\[\033[0;36m\]:\[\033[1;36m\]\w\[\033[0;36m\] #\[\033[0;27m\] '
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
PAGER='less -SFXR -x2'
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
