#!/bin/bash
source lib/functions.sh
source lib/brew-pkg-select.sh

# Brew Install packages
echo "🥤   Installing homebrew packages"

# Tap the cask-versions repo
brew tap homebrew/cask-versions

# Required packages
REQUIRED_PKGS=(
    "cmake" # Cross-platform make
    "diff-so-fancy" # Good-lookin' diffs with diff-highlight and more
    "gnupg" # GNU Pretty Good Privacy (PGP) package
    "mas" # Mac App Store command-line interface
    "node" # JS Engine
    "pinentry-mac" # Pinentry for GPG on Mac
    "python" # Python programming language
)
brew install ${REQUIRED_PKGS[@]}

BREW_PKGS=(
    "awscli" # Official Amazon AWS command-line interface
    "bat" # A better cat
    "colordiff" # Color-highlighted diff(1) output
    "ctags" # Generate tags found in source files
    "entr" # Run arbitrary commands when files change
    "fd" # Simple, fast and user-friendly alternative to find
    "fpp" # Facebook Path Picker
    "fx" # Terminal JSON viewer
    "fzf" # Command-line fuzzy finder
    "gh" # GitHub CLI
    "git" # ... git
    "git-secrets" # Prevents you from committing sensitive information to a git repo
    "git-extras" # Extra git commands
    "go" # The Go programming language
    "gping" # Ping, but with a graph
    "grip" # Github-flavored markdown previewer
    "gron" # Make JSON greppable
    "hadolint" # Dockerfile linter
    "helm" # K8s Package Manager
    "hr" # <hr />, for your terminal window
    "httpie" # User-friendly cURL replacement
    "iredis" # Redis CLI replacement
    "jq" # Command-line JSON processor
    "jsonlint" # JSON validator
    "kubectx" # Switch between kubectl contexts easily
    "kubernetes-cli" # ... k8s CLI
    "litecli" # SQLite CLI
    "markdownlint-cli" # CLI for a markdown linter
    "mycli" # MySQL CLI
    "nvim" # Neovim
    "nvm" # Node Version Manager
    "oha" # HTTP load generator, inspired by rakyll/hey
    "pgcli" # Postgres CLI
    "pv" # Monitor data's progress through a pipe
    "pyenv" # Python version manager
    "python-yq" # Command-line YAML and XML processor that wraps jq
    "redpen" # Proofreading tool to help writers of technical documentation
    "ripgrep" # Search tool like grep and The Silver Searcher
    "sops" # Simple and flexible tool for managing secrets
    "spacer" # Small command-line utility for adding spacers to command output
    "tailspin" # Log colorizer
    "terminal-notifier" # Send macOS User Notifications from the command-line
    "thefuck" # Programmatically correct mistyped console commands
    "tidy-html5" # Granddaddy of HTML tools, with support for modern standards
    "tldr" # Simplified and community-driven man pages
    "tree" # Display directories as trees
    "watch" # Executes a program periodically, showing output fullscreen
    "wget" # Internet File Retriever
    "yamllint" # YAML linter
    "yarn" # JS package manager

    # Casks

    "homebrew/cask/aerial" # AppleTV Aerial Screensaver - Needed? Directly replaced by MacOS
    "homebrew/cask/base" # SQLite 3 database App
    "homebrew/cask/bloop" # AI Code search engine
    "homebrew/cask/google-cloud-sdk" # Manage Google Cloud
    "homebrew/cask/iterm2" # A better MacOS Terminal
    "homebrew/cask/macdown" # Open-source Markdown editor App
    "homebrew/cask/sequel-pro" # MySQL/MariaDB database management platform
    "homebrew/cask/vimr" # GUI for the Neovim text editor
    "homebrew/cask/visual-studio-code" # Open-source code editor
    "homebrew/cask/slite" # Team communication and collaboration software
    "homebrew/cask/fellow" # Collaborative meeting agendas, notes, and action items
    "homebrew/cask/docker" # Docker CE
    "homebrew/cask/macvim" # GUI app for the Vim text editor
    "homebrew/cask/notion-calendar" # Calendar for professionals and teams
    "homebrew/cask/zoom" # Calendar for professionals and teams
    ## Browsers
    "homebrew/cask/arc"
    "homebrew/cask/firefox"
    "homebrew/cask/google-chrome"
        # "homebrew/cask/brave-browser"
        # "homebrew/cask-versions/safari-technology-preview"
        # "homebrew/cask-versions/google-chrome-canary"

    # Custom taps
    "keith/formulae/reminders-cli" # Do I actually use this?

    # Previously used but no longer requested on install. These are here for reference
    # as I sometimes want to go remember what they were and install them. "What did I
    # used to install by default?" I hear you saying "Why not just look at commit
    # history, that's where that belongs?" And sure, I could parse all the git commits
    # to find what's been in there. But this is not history, this is notes. Things I
    # want to be able to easily reference. So I leave them here. Deal with it.
    # "hey" # Replaced by oha
    # "jid" # Json Incremental Digger
    # "joplin-cli" # Markdown note manager. I just use osx notes now.
    # "lynx" # I very rarely use a CLI browser these days
    # "ngrok" # Replaced with localtunnel via npm. But I use both.
    # "nodeenv" # Not installed by default
    # "pre-commit" # Useful reference to precommit config tooling
    # "svgo" # Nodejs-based tool for optimizing SVG vector graphics files
    # "wireguard-go" # Fast, Madern VPN Tunnel (in go)
    # "yadm" Yet Another Dotfiles Manager. Should I use this?
    # "homebrew/cask/imagealpha" # Front-end tooling
    # "homebrew/cask/imageoptim" # Front-end tooling
    # "homebrew/cask/muzzle" # Feature is built in to OSX now.
)

multi_select_from_list "${BREW_PKGS[@]}"

echo "🥤   Installing: ${selected_packages[@]}"
brew install ${selected_packages[@]}
