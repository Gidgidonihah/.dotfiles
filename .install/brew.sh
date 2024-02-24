#!/bin/bash
source lib/functions.sh
source lib/brew-pkg-select.sh

# Brew Install packages
echo "🥤   Installing homebrew packages"

# Tap the cask-versions repo
brew tap homebrew/cask-versions

# Tap the spacer keg to install spacer
brew tap samwho/spacer

# Required packages
REQUIRED_PKGS=(
    "cmake"
    "diff-so-fancy"
    "gnupg"
    "mas"
    "node"
    "pinentry-mac"
    "python"
)
brew install ${REQUIRED_PKGS[@]}

BREW_PKGS=(
    # TODO @jweir: document what each is so I don't have to remember why I keep them around
    "aerial"
    "awscli"
    "base"
    "bat"
    "bloop"
    "brave"
    "colordiff"
    "ctags"
    "entr"
    "fd"
    "firefox"
    "fpp"
    "fx"
    "fzf"
    "gh"
    "git"
    "git-secrets"
    "git-extras"
    "go"
    "google-chrome"
    # "google-chrome-canary"
    "google-cloud-sdk"
    "gping"
    "grip"
    "gron"
    "hadolint"
    "helm"
    "hey"
    "hr"
    "httpie"
    # "imagealpha"
    # "imageoptim"
    "iredis"
    "iterm2"
    # "jid"
    # "joplin"
    "jq"
    "jsonlint"
    "kubectx"
    "kubernetes-cli"
    "litecli"
    # "lynx"
    "macdown"
    "markdownlint-cli"
    # "muzzle"
    "mycli"
    # "ngrok" # Replaced with localtunnel via npm
    # "nodeenv"
    "nvim"
    "nvm"
    # "parallel"
    "pgcli"
    # "pre-commit"
    "pv"
    "pyenv"
    "python-yq"
    "redpen"
    "ripgrep"
    # "safari-technology-preview"
    "sequel-pro"
    # "sip"
    # "sops"
    "spacer"
    "svgo"
    "tailspin" # Log colorizer
    "terminal-notifier"
    "thefuck"
    "tidy-html5"
    "tldr"
    # "transmission"
    "tree"
    "vimr"
    "visual-studio-code"
    "watch"
    "wget"
    # "wireguard-go"
    # "yadm" Yet Another Dotfiles Manager. Should I use this?
    "yamllint"
    "yarn"
    "zoom"
    "homebrew/cask/macvim" # Never installs properly. Also
    "homebrew/cask/docker"
    "keith/formulae/reminders-cli" # Do I actually use this?
)

multi_select_from_list "${BREW_PKGS[@]}"

echo "🥤   Installing: ${selected_packages[@]}"
brew install ${selected_packages[@]}
