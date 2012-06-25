# .bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ls options differ between my mac an unix boxes.
if [ ${OSTYPE//[0-9.]/} == 'darwin' ]; then
	#mac
	alias ls='ls -G'

	alias sshs='ssh root@jason.dev.dropship.com'
	alias cleanup="chflags -R nouchg ."
	alias cup="cleanup"
	alias dcup="dot_clean -mv /Volumes/build/"
	alias ssbg='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
else
	#linux
	alias ls='ls --color'

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
