# .bashrc

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias ll='ls -al --color'
alias lh="ls -alh --color"
alias cls="clear; ls"
alias elog="tail -f /var/log/apache2/error_log"
alias findebug="grep -rni "{debug}" *"
alias mongo="mongo -uroot -pp2mfun DropshipCommon"

PS1="\[\033[1;34m\]\t\[\033[0;36m\]|\h\[\033[0;36m\]:\[\033[1;36m\]\w\[\033[0;36m\] #\[\033[0;27m\] "
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
PAGER='less -FXRS -x2'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
if [ -n "${SSH_CLIENT}" ]; then
    cd /home/build/dropship.com/;
fi

function findall(){
	DIR="/tmp/search_results";
	[ -d "$DIR" ] || mkdir $DIR;
	NOW=$(date +"%M%S");
	ack "$@" /home/build/global /home/build/doba.com/ /home/build/*.doba.com /home/build/dropship.com /home/build/productsourcing.com | tee $DIR/search_result_$NOW.txt;
	echo $DIR/search_result_$NOW.txt;
}
function search(){
	DIR="/tmp/search_results";
	[ -d "$DIR" ] || mkdir $DIR;
	NOW=$(date +"%M%S");
	ack "$@" * | tee $DIR/search_result_$NOW.txt;
	echo $DIR/search_result_$NOW.txt;
}
function sandr(){ # takes 2 inputs: search, replace
	SEARCH=$1;
	REPLACE=$2;
	CMD="ack '$SEARCH' -l --print0 | xargs -0 -L1 sed -i 's/$SEARCH/$REPLACE/g'";

	echo $CMD;
	echo '------------------------------------------------------------------------';
	eval $CMD;
}
