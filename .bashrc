# .bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ls options differ between my mac an unix boxes.
if [ ${OSTYPE//[0-9.]/} == 'darwin' ]; then
	#mac
	alias ls='ls -aG'

	alias sshs='ssh root@jason.dev.dropship.com'
	alias sshm='ssh 192.168.11.2'
	alias cleanup="chflags -R nouchg ."
	alias cup="cleanup"
	alias dcup="dot_clean -mv /Volumes/build/"
	alias ssbg='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
	alias find="find . -iname"
else
	#linux
	alias ls='ls --color -a'

	alias sshs='echo "You are already on the dev server, dummy."'
	alias mongoa="mongo -uroot -pp2mfun DropshipCommon"
	alias mongob="mongo -uroot -pp2mfun DropshipCatalog"
	alias drupal_db="~/boxbuilder/scripts/drupal_db.sh"

	if [ -d /home/build/dropship.com -a -n "${SSH_CLIENT}" ]; then
		cd /home/build/dropship.com/;
	fi
fi

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias ll='ls -al'
alias lh="ls -alh"
alias ping="ping -c4"
alias cls="clear; ls"
alias phpunit="phpunit --colors"
alias cls="clear; ls"
alias elog="tail -f /var/log/apache2/error_log"

function ssh-id-copy(){
	SERVER=$1;
	CMD="cat ~/.ssh/id_rsa.pub | ssh $SERVER 'cat >> ~/.ssh/authorized_keys'"
	eval $CMD;
}
function screenSaver(){
	a=1;x=1;y=1;xd=1;yd=1;while true;do if [[ $x == $LINES || $x == 0 ]]; then xd=$(( $xd *-1 )) ; fi ; if [[ $y == $COLUMNS || $y == 0 ]]; then yd=$(( $yd * -1 )) ; fi ; x=$(( $x + $xd )); y=$(( $y + $yd )); printf "\33[%s;%sH\33[48;5;%sm \33[0m" $x $y $(($a%199+16)) ;a=$(( $a + 1 )) ; sleep 0.001 ;done
}

function vack(){
	SEARCH=$1;
	CMD="vi \`ack '$SEARCH' -l --print0 | xargs -0 -L1\`";
	eval $CMD;
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
function releaseCode(){
	SERVERS=$1
	if [ -z "$SERVERS" ]; then
		SERVERS="01 02 03 04 05 06 07"
	else
		if [ $SERVERS -lt 10 ]; then
			SERVERS='0'$SERVERS
		fi
	fi
	for SERVER in $SERVERS
	do
		ssh root@dsapp$SERVER 'cd /home/build/dropship.com/ && git pull && git branch'
	echo '------------------------------------------------------------------------';
	done
}
function releaseJobs(){
	SERVERS=$1
	if [ -z "$SERVERS" ]; then
		SERVERS="01 02 03 04 05 06 07"
	else
		if [ $SERVERS -lt 10 ]; then
			SERVERS='0'$SERVERS
		fi
	fi
	for SERVER in $SERVERS
	do

		CMD="ssh root@dsapp$SERVER 'cd /home/build/jobs && git pull && git branch'";
		echo $CMD;
		echo '------------------------------------------------------------------------';
		eval $CMD;

	done
}
