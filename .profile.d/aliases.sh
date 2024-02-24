# Alias for thefuck
eval "$(thefuck --alias f)"

# General aliases
alias please='sudo'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -AG'
alias lh="ls -alh"
alias dc='docker compose'
alias xdg-open="open"
alias tf=terraform
alias copy="tr -d '\n' | pbcopy"
alias cat="bat"
alias ff="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias grep="grep --exclude-dir=node_modules" # I never want to grep node modules...
alias m=music
alias fd="fd -H" # Always include searching for .hidden files
alias tree="tree -I \"*pyc|__pycache__\""

# Get my current IP address
alias ip="ifconfig en0 | awk '$1 == "inet" {print $2}'" # Get your IPv4 IP address from ifconfig.
alias ipv6="ifconfig en0 | awk '$1 == "inet6" {print $2}'" # Get your IPv6 IP address from ifconfig.
alias myip='IP=$(dig +short myip.opendns.com @resolver1.opendns.com) && echo "My WAN/Public IP address: ${IP}"'
alias ,ip="ifconfig en0 | awk '$1 == "inet" {print $2}'" # Get your IPv4 IP address from ifconfig.
alias ,ipv6="ifconfig en0 | awk '$1 == "inet6" {print $2}'" # Get your IPv6 IP address from ifconfig.
alias ,myip='IP=$(dig +short myip.opendns.com @resolver1.opendns.com) && echo "My WAN/Public IP address: ${IP}"'

# get image dimensions
alias ,imgdim='sips -g pixelHeight -g pixelWidth $1'

# User specific aliases and functions
alias ping="ping -c4"
alias ,stfp="git status | fpp"

# k8s aliases
alias k=kubectl
alias ,k=kubectl
alias kx=kubectx
alias ,kx=kubectx
alias kns=kubens
alias ,kns=kubens

# Typo aliases
# See typos.sh

# SSH to common servers
alias sshm='ssh 192.168.1.50'
alias sshg='ssh gidgidonihah.com'

# Remove some oh-my-zsh plugin aliases
unalias y 2> /dev/null

# Run command without network
alias ,nonet="sandbox-exec -f ~/no-network.sandbox"

# Multi repo search
# alias ggg="~/.sh/multi-repo-search.sh ~/Sites/"

# Facbook path picker is silly
alias fpp="fpp --non-interactive"

# Officially switching over to neovim
alias vvim="/usr/local/bin/vim"
alias vim="nvim"
alias vi="nvim"

# Open vim without a user profile
alias ,uvim="vi -u NONE"

# Give me a uuid quick and easy to my clipboard
alias ,uuid='uuidgen | tr -d "\n" | tr "[:upper:]" "[:lower:]" | pbcopy'
