# .bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source the profile scripts
for f in ~/.profile.d/*; do
    source $f
done

# Facebook Path Picker
export FPP_DISABLE_SPLIT=false

# ls options differ between my mac an unix boxes.
if [ ${OSTYPE//[0-9.]/} == 'darwin' ]; then
    #mac
    alias l='/bin/ls'
    alias ls='ls -aG'
    alias salt='ssh ec2-user@salt.doba.com'
    alias dc='docker-compose'
    alias xdg-open="open"

    # pylint modified python files
    # git status --porcelain | awk 'match($0, "[AM].*.py"){print $2}' | xargs pylint

    # Get my current IP address
    alias ip="ifconfig en0 | grep inet[^6] | awk  -F\"[: \t]+\" '{print $3}'" # Get your IPv4 IP address from ifconfig. This is the Mac version.
    alias ipv6="ifconfig en0 | grep inet[^6] | awk  -F\"[ \t]+\" '{print $3}'" # Get your IPv6 IP address from ifconfig. This is the Mac version.

    # Tail apache logs with human readable formatting
    alias elog="tail -f /var/log/apache2/error_log | sed 's/\\\\n/\\n/g'"

    # get image dimensions
    alias imgdim='sips -g pixelHeight -g pixelWidth $1'

    # thefuck
    eval "$(thefuck --alias f)"
else
    #linux
    alias ls='ls -a --color'

    for f in /etc/bash_completion.d/*; do
        source $f
    done
fi

export EDITOR='/usr/local/bin/vim'

# User specific aliases and functions
alias gi='git'
alias tgit='git'
alias ggg="~/.sh/git-search.sh"
alias fng="find . | grep -i"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias ll='ls -al'
alias lh="ls -alh"
alias ping="ping -c4"
alias phpunit="phpunit --colors"
alias cls="clear; ls"

# SSH to common servers
alias sshm='ssh 192.168.1.50'
alias sshg='ssh gidgidonihah.com'

function retailcomic(){
    cd ~/Sites;
    python2.7 retailcomic.py
    open retailcomic.html;
    sleep 1;
    rm -f retailcomic.html
}

function gg(){
    git ick "$@" | sed -e "s/\(^[a-zA-Z].*\)/`echo -e '\033[1;34m'`\1`echo -e '\033[0m'`/" | $PAGER
}

function vig(){
    vi `git grep -il "$@" | tr "\n" " "`
}

function ssh-id-copy(){
    SERVER=$1;
    CMD="cat ~/.ssh/id_rsa.pub | ssh $SERVER 'cat >> ~/.ssh/authorized_keys'"
    eval $CMD;
}

function screenSaver(){
    a=1;x=1;y=1;xd=1;yd=1;while true;do if [[ $x == $LINES || $x == 0 ]]; then xd=$(( $xd *-1 )) ; fi ; if [[ $y == $COLUMNS || $y == 0 ]]; then yd=$(( $yd * -1 )) ; fi ; x=$(( $x + $xd )); y=$(( $y + $yd )); printf "\33[%s;%sH\33[48;5;%sm \33[0m" $x $y $(($a%199+16)) ;a=$(( $a + 1 )) ; sleep 0.001 ;done
}

shrug(){ echo -n "¯\_(ツ)_/¯" | (pbcopy||xsel);echo "¯\_(ツ)_/¯ copied to your clipboard"; }
