# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  emoji
  autoenv
  colored-man-pages
  docker
  docker-compose
  git
  notify
  osx
  scd
  thefuck
  vi-mode
  virtualenv
  virtualenvwrapper
  yarn
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
#
# Notes:
# * Don't forget about `fpp` for easily selecting files
# * learn these commands:
#     https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/osx
# * learn the aliases (see `alias`)

# Update path
export PATH="/usr/local/sbin:$PATH"

# Enable Vi mode
bindkey -v
export KEYTIMEOUT=1

# Auto pushd
setopt AUTO_PUSHD

# shift+tab to go backwards
bindkey '^[[Z' reverse-menu-complete

# Source the zsh profile scripts
# See .profile.d/common.sh for shared (bash/zsh) settings
# See .profile.d/aliases.sh for commonly used aliases # See .profile.d/functions.sh for commonly used functions
for f in ~/.profile.d/*.zsh ~/.profile.d/*.sh; do
    source $f
done
