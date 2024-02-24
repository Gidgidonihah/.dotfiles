function ,pycover(){
    LOCATION=${1:-discover}
    echo "Running tests against $LOCATION"
    find . -iname '*.py' | entr -c -s "hr; coverage run -m --omit='*test*' --source=. unittest $LOCATION && coverage html"
}

function retailcomic(){
    cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/App\ Sync/RetailComic
    python3 retailcomic.py
    open -a Safari retailcomic.html
    sleep 1
    cd -
}

function ,colortail() {
    tail $@ | bat --paging=never -l log --style=numbers
}

function gitick(){
    # Ignoring db/ because it's often filled with loads of db data and often useless
    hr; git ick "$@" -- ':(exclude)db/' | sed -e "s/\(^[a-zA-Z].*\)/`echo -e '\033[1;34m'`\1`echo -e '\033[0m'`/" | $PAGER
}
alias gg='noglob gitick' # Overwrite a possible default alias for gg from the oh-my-zsh git plugin
alias ,gg=gg
function gi(){
    git ack "$@" | sed -e "s/\(^[a-zA-Z].*\)/`echo -e '\033[1;34m'`\1`echo -e '\033[0m'`/" | $PAGER
}
alias ,gi=gi
function vig(){
    noglob nvim `noglob git grep -Iil "$@" | tr "\n" " "`
}
alias ,vig=vig

function page(){
    cat $@ | $PAGER
}
alias ,page=page

function ssh-id-copy(){
    SERVER=$1;
    cat ~/.ssh/id_rsa.pub | ssh $SERVER 'cat >> ~/.ssh/authorized_keys'
}
alias ,ssh-id-copy=ssh-id-copy

shrug(){
    echo -n "¯\_(ツ)_/¯" | (pbcopy||xsel);
    echo "¯\_(ツ)_/¯ copied to your clipboard";
}
alias ,shrug=shrug
rainymood() {
    FILE=$((RANDOM%4))
    URL="https://rainymood.com/audio1110/${FILE}.ogg"
    mpv "$URL" && rainymood
}
alias ,rainymood=rainymood
ztheme(){
    export ZSH_THEME="$@" && source $ZSH/oh-my-zsh.sh
}

,jiralink() {
    local arg1=$1
    local arg2=$2
    local link_type=${3:-Blocks}
    local prefix=${4:-TER}

    jira issue link "$prefix-$arg1" "$prefix-$arg2" "$link_type"
}
