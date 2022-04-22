#!/bin/bash

# Brew Install packages
echo "🥤   Installing homebrew packages"

# Tap the cask-versions repo
brew tap homebrew/cask-versions

# Required packages
REQUIRED_PKGS=(
    "cmake"
    "gnupg"
    "mas"
    "node"
    "pinentry-mac"
    "python"
)
brew install ${REQUIRED_PKGS[@]}

BREW_PKGS=(
    "aerial"
    "awscli"
    "base"
    "bat"
    "brave"
    "colordiff"
    "ctags"
    "diff-so-fancy"
    "entr"
    "fd"
    "firefox"
    "fpp"
    "fx"
    "fzf"
    "gh"
    "git"
    "git-secrets"
    "go"
    "google-chrome"
    "google-chrome-canary"
    "google-cloud-sdk"
    "gping"
    "grip"
    "gron"
    "hadolint"
    "helm"
    "hey"
    "hr"
    "httpie"
    "imagealpha"
    "imageoptim"
    "iredis"
    "iterm2"
    "jid"
    "joplin"
    "jq"
    "jsonlint"
    "kubectx"
    "kubernetes-cli"
    "litecli"
    "lynx"
    "macdown"
    "muzzle"
    "mycli"
    "ngrok"
    "nodeenv"
    "nvm"
    "parallel"
    "pgcli"
    "pre-commit"
    "pv"
    "pyenv"
    "python-yq"
    "redpen"
    "ripgrep"
    "safari-technology-preview"
    "sequel-pro"
    "sip"
    "sops"
    "svgo"
    "terminal-notifier"
    "thefuck"
    "tidy-html5"
    "tldr"
    "transmission"
    "tree"
    "visual-studio-code"
    "watch"
    "wget"
    "wireguard-go"
    "yadm"
    "yamllint"
    "yarn"
    "zoom"
    "homebrew/cask/macvim"
    "homebrew/cask/docker"
    "keith/formulae/reminders-cli"
)

multi_select_from_list "${BREW_PKGS[@]}"

echo "🥤   Installing: ${selected_packages[@]}"
brew install ${selected_packages[@]}
