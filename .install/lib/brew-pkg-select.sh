#!/bin/bash

getInfo() {
    local json desc url

    # Exit silently if an arg was not passed
    [[ $# -gt 0 ]] || return

    # jq is needed, so install if not available
    if ! hash jq 2>/dev/null; then
        brew install jq
    fi

    # Try searching for package info from homebrew
    json=$(brew info --json $1 2> /dev/null)
    if [[ "$json" ]]; then
        desc=$(echo $json | jq -r '.[0].desc')
        url=$(echo $json | jq -r '.[0].homepage')
    fi

    # If that fails, try searching NPM
    if [[ ! "$json" ]]; then
        json=$(npm show --json $1 2> /dev/null)
        if [[ "$json" ]]; then
            desc=$(echo $json | jq -r '.description')
            url=$(echo $json | jq -r '.homepage')
        fi
    fi

    if [[ "$desc" ]]; then
        echo "${cyan}$1${reset}: ${yellow}$desc${reset}"
        [[ "$url" ]] && echo "For more information see ${green}$url${reset}"
    else
        echo "No information found for ${yellow}$1${reset}"
    fi
}

ask() {
    local prompt default reply
    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'
        default='N'
    else
        prompt='y/n'
        default=''
    fi

    # If a package name is supplied, offer help option
    if [[ $# -gt 2 ]]; then
        prompt="$prompt/?"
    fi

    while true; do
        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 ${dim}[$prompt]${reset} "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
            H*|h*|?*) getInfo $3 ;;
        esac
    done
}

multi_select_from_list() {
    local options
    selected_packages=() # Global var for selected results
    options=$@
    for option in ${options[@]}; do
        # Default to Yes if the user presses enter without giving an answer:
        if ask "Include $option?" Y $option; then
            selected_packages+=("$option")
        fi
    done
}
