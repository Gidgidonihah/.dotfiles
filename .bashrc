# .bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source the profile scripts
for f in ~/.profile.d/*; do
    source $f
done

# Fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Facebook Path Picker
export FPP_DISABLE_SPLIT=false

# Searchers
if [ -f ~/Dropbox/Sites/searcher/.searchrc ]; then
    . ~/Dropbox/Sites/searcher/.searchrc
fi

# ls options differ between my mac an unix boxes.
if [ ${OSTYPE//[0-9.]/} == 'darwin' ]; then
	#mac
	alias ls='ls -aG'
	alias salt='ssh ec2-user@salt.doba.com'

    # Doba Dev Settings
	alias sshs='ssh root@jweir.dev.doba.com'
    alias cdc='cd ~/Sites/doba/'
    alias cdd='cd ~/Sites/doba/docker.doba.com/'
	#t alias sql='mysql --auto-rehash -uroot -pQu@ntum Doba'

	alias ssbg='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
	alias ip="ifconfig en0 | grep inet[^6] | awk  -F\"[: \t]+\" '{print $3}'" # Get your IPv4 IP address from ifconfig. This is the Mac version.
	alias ipv6="ifconfig en0 | grep inet[^6] | awk  -F\"[ \t]+\" '{print $3}'" # Get your IPv6 IP address from ifconfig. This is the Mac version.

	alias elog="tail -f /var/log/apache2/error_log | sed 's/\\\\n/\\n/g'"
	alias xdg-open="open"

	# get image dimensions
	alias imgdim='sips -g pixelHeight -g pixelWidth $1'

	alias sshm='ssh 192.168.1.50'
    alias sshg='ssh gidgidonihah.com'

    # thefuck
    eval "$(thefuck --alias f)"
else
	#linux
	alias ls='ls -a --color'

	alias sshs='echo "You are already on the dev server, dummy."'
	alias sql='mysql --auto-rehash -uroot -pQu@ntum Doba'
	alias runserver="cd /home/build/new.doba.com/ && ./manage.py runserver_plus --cert tmp 0.0.0.0:8000"
	alias elog="tail -f /var/log/httpd/error_log | sed 's/\\\\n/\\n/g'"

    for f in /etc/bash_completion.d/*; do
        source $f
    done

	if [ -d /home/build/new.doba.com -a -n "${SSH_CLIENT}" ]; then
		cd /home/build/new.doba.com/;
	fi
fi

export EDITOR='/usr/bin/vim'

# User specific aliases and functions
alias gi='git'
alias ggg="~/.sh/git-search.sh"
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

function retailcomic(){
	cd ~/Sites;
	python retailcomic.py
	open retailcomic.html;
	sleep 1;
	rm -f retailcomic.html
}

function gg(){
	git ack "$@" | sed -e "s/\(^[a-zA-Z].*\)/`echo -e '\033[1;34m'`\1`echo -e '\033[0m'`/" | $PAGER
}

function vig(){
	vi `git grep -l "$@" | tr "\n" " "`
}

function ssh-id-copy(){
	SERVER=$1;
	CMD="cat ~/.ssh/id_rsa.pub | ssh $SERVER 'cat >> ~/.ssh/authorized_keys'"
	eval $CMD;
}

function screenSaver(){
	a=1;x=1;y=1;xd=1;yd=1;while true;do if [[ $x == $LINES || $x == 0 ]]; then xd=$(( $xd *-1 )) ; fi ; if [[ $y == $COLUMNS || $y == 0 ]]; then yd=$(( $yd * -1 )) ; fi ; x=$(( $x + $xd )); y=$(( $y + $yd )); printf "\33[%s;%sH\33[48;5;%sm \33[0m" $x $y $(($a%199+16)) ;a=$(( $a + 1 )) ; sleep 0.001 ;done
}

shrug(){ echo -n "¯\_(ツ)_/¯" | (xsel||pbcopy);echo "¯\_(ツ)_/¯ copied to your clipboard"; }
