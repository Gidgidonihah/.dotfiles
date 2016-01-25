# Source local bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
PAGER='less -SFXR -x2'
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
