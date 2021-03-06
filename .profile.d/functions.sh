function retailcomic(){
    cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/App\ Sync/RetailComic
    python2.7 retailcomic.py
    open -a Safari retailcomic.html
    sleep 1
    cd -
}

function gitick(){
    hr; git ick "$@" | sed -e "s/\(^[a-zA-Z].*\)/`echo -e '\033[1;34m'`\1`echo -e '\033[0m'`/" | $PAGER
}
alias gg='noglob gitick' # Overwrite a possible default alias for gg from the oh-my-zsh git plugin
function page(){
    cat $@ | $PAGER
}

function gi(){
    git ack "$@" | sed -e "s/\(^[a-zA-Z].*\)/`echo -e '\033[1;34m'`\1`echo -e '\033[0m'`/" | $PAGER
}

function vig(){
    noglob vim `noglob git grep -il "$@" | tr "\n" " "`
}

function ssh-id-copy(){
    SERVER=$1;
    CMD="cat ~/.ssh/id_rsa.pub | ssh $SERVER 'cat >> ~/.ssh/authorized_keys'"
    eval $CMD;
}

shrug(){
    echo -n "¯\_(ツ)_/¯" | (pbcopy||xsel);
    echo "¯\_(ツ)_/¯ copied to your clipboard";
}
rainymood() {
    FILE=$((RANDOM%4))
    URL="https://rainymood.com/audio1110/${FILE}.ogg"
    mpv "$URL" && rainymood
}
