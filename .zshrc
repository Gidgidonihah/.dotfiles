# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
DEFAULT_USER="jason"
export VIRTUAL_ENV_DISABLE_PROMPT=1 # Disable default virtualenv ps1 (replaced w/ agnoster)
ZSH_THEME="powerlevel10k/powerlevel10k"

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
  # TODO:
  fancy-ctrl-z  # TODO @jweir: why is this not working? I WANT it!
  notify # TODO @jweir: perhaps try built in bgnotify instead?

  # Trying out
  frum # Ruby version manager

  # Removed, but want a reference for now
  # asdf # Man, ASDF sucks. I don't want to use it ever again.
  # chruby Trying frum instead. All in 1 and whatnot
  # pyenv

  # Take a look at and maybe add?
  # ssh-agent
  # gpg-agent
  # keychain
  # jump
  # jira
  # systemadmin
  # git-auto-fetch
  # genpass
  # branch
  # bgnotify

  # Installed and loving them
  alias-finder
  aliases
  aws
  catimg
  colored-man-pages
  command-not-found
  copybuffer
  cp
  docker
  docker-compose
  emoji
  extract
  fast-syntax-highlighting
  gcloud
  git
  git-extras
  httpie
  isodate
  kubectl
  kubectx
  last-working-dir
  macos
  poetry
  python
  rsync
  scd
  thefuck
  vi-mode
  virtualenvwrapper
  yarn
  zsh-autosuggestions

)

# Source homebrew before everything
source ~/.profile.d/brew.sh

# Virtuanenvwrapper started complaining suddenly on startup, but if I include this
# config before running omz setup, then everything is happy. No idea what changed. I
# went to lunch, came back and opened a terminal tab. Go figure.
source ~/.profile.d/virtualenvwrapper.sh

source $ZSH/oh-my-zsh.sh

# User configuration
#
# Notes:
# * Don't forget about `fpp` for easily selecting files
# * learn these commands:
#     https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/osx
# * learn the aliases (see `alias`)

# Update path
export PATH="$HOME/.rbenv/shims:$HOME/.bin:/usr/local/sbin:$PATH"
# Add non VC scripts (stored on icloud for backup, but not ready for commit)
export PATH="$HOME/Documents/.bin:$PATH"

# Spelling correction
# setopt correct # Or `correctall` for param correction

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh
