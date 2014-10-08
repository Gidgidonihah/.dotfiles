# .bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ls options differ between my mac an unix boxes.
if [ ${OSTYPE//[0-9.]/} == 'darwin' ]; then
	#mac
	alias ls='ls -aG'

	alias sshs='ssh root@jweir.dev.doba.com'
	alias sshm='ssh 192.168.1.2'
	alias cleanup="chflags -R nouchg ."
	alias cup="cleanup"
	alias dcup="dot_clean -mv /Volumes/build/"
	alias ssbg='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
	alias find="find . -iname"
	alias ip="ifconfig en0 | grep inet[^6] | awk  -F\"[: \t]+\" '{print $3}'" # Get your IPv4 IP address from ifconfig. This is the Mac version.
	alias ipv6="ifconfig en0 | grep inet[^6] | awk  -F\"[ \t]+\" '{print $3}'" # Get your IPv6 IP address from ifconfig. This is the Mac version.
	alias elog="tail -f /var/log/apache2/error_log | sed 's/\\\\n/\\n/g'"
	alias xdg-open="open"

	# get image dimensions
	alias imgdim='sips -g pixelHeight -g pixelWidth $1'
else
	if [ -f ~/.sh/bash-ps1.sh ]; then
		. ~/.sh/bash-ps1.sh
	fi
	#linux
	alias ls='ls -a --color'

	alias fn="find -iname"
	alias sshs='echo "You are already on the dev server, dummy."'
	alias mysql='mysql --auto-rehash -uroot -pQu@ntum'
	alias drupal_db="~/boxbuilder/scripts/drupal_db.sh"
	alias ip="ifconfig eth0 | grep inet[^6] | awk  -F\"[: \t]+\" '{print $4}'" # Get your IPv4 IP address from ifconfig. This is the Linux version.
	alias ipv6="ifconfig eth0 | grep inet6 | awk  -F\"[ \t]+\" '{print $4}'" # Get your IPv6 IP address from ifconfig. This is the Linux version.
	alias runserver="cd /home/build/new.doba.com/ && ./manage.py runserver 0.0.0.0:8000"
	alias runserverbg="cd /home/build/new.doba.com/ && nohup ./manage.py runserver 0.0.0.0:8000 >> /tmp/runserver & 2>&1"
	alias elog="tail -f /var/log/httpd/error_log | sed 's/\\\\n/\\n/g'"

	source /etc/bash_completion.d/*

	if [ -d /home/build/new.doba.com -a -n "${SSH_CLIENT}" ]; then
		cd /home/build/new.doba.com/;
	fi

	alias pip="pip2.7"
	alias python="python2.7"

	export EDITOR='vim'
fi

# User specific aliases and functions
alias gi='git'
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
alias bing="cd ~/Sites;python bingsearcher.py"

function retailcomic(){
	cd ~/Sites;
	python retailcomic.py $1 > retailcomic.html;
	echo $1 > 'last-retail-comic-date.txt';
	open retailcomic.html;
	sleep 1;
	rm -f retailcomic.html
}

alias ggg="~/.sh/git-search.sh"
function gg(){
	git ack "$@" | sed -e "s/\(^[a-zA-Z].*\)/`echo -e '\033[1;34m'`\1`echo -e '\033[0m'`/" | $PAGER
}
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
function browserStack(){
	DOMAIN=$1
	SSH=$2
	PORT=$3
	SSHPORT=$4
	BSKEY=`cat ~/.ssh/browserstack.key`

	if [ -z "$DOMAIN" ]
	then
	   DOMAIN='jweir.dev.doba.com'
	fi

	if [ -z "$PORT" ]
	then
	   PORT="80"
	fi

	if [ -z "$SSH" ]
	then
	   SSH="1"
	fi

	if [ -z "$SSHPORT" ]
	then
	   SSHPORT="443"
	fi

	if [ -z "$BSKEY" ]
	then
	   echo 'Please store your BrowserStack CLI local testing key in "~/.ssh/browserstack.key"'
	   return;
	fi

	CMD="java -jar /usr/local/lib/BrowserStackTunnel.jar $BSKEY $DOMAIN,$PORT,0"
	if [ 1 == $SSH ]
	then
		CMD=$CMD",$DOMAIN,$SSHPORT,$SSH"
	fi

	eval $CMD
}
