# Alias for thefuck
eval "$(thefuck --alias f)"

# General aliases
alias please='sudo'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -aG'
alias lh="ls -alh"
alias dc='docker compose'
alias xdg-open="open"
alias tf=terraform
alias copy="tr -d '\n' | pbcopy"
alias cat="bat"
alias ff="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# Get my current IP address
alias ip="ifconfig en0 | grep inet[^6] | awk  -F\"[: \t]+\" '{print $3}'" # Get your IPv4 IP address from ifconfig.
alias ipv6="ifconfig en0 | grep inet[^6] | awk  -F\"[ \t]+\" '{print $3}'" # Get your IPv6 IP address from ifconfig.
alias myip='IP=$(dig +short myip.opendns.com @resolver1.opendns.com) && echo "My WAN/Public IP address: ${IP}"'

# Tail apache logs with human readable formatting
alias elog="tail -f /var/log/apache2/error_log | sed 's/\\\\n/\\n/g'"

# get image dimensions
alias imgdim='sips -g pixelHeight -g pixelWidth $1'

# # User specific aliases and functions
alias gi='git'
alias gti='git'
alias grm='git rm'
alias tgit='git'
alias ping="ping -c4"
alias stfp="git status | fpp"

# SSH to common servers
alias sshm='ssh 192.168.1.50'
alias sshg='ssh gidgidonihah.com'

# Remove some oh-my-zsh plugin aliases
unalias y 2> /dev/null

# Run command without network
alias nonet="sandbox-exec -f ~/no-network.sandbox"

# Multi repo search
# alias ggg="~/.sh/multi-repo-search.sh ~/Sites/"
