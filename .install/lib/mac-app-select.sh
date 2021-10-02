#!/bin/bash

multi_select_app_from_list() {
    local options app_name
    selected_packages=() # Global var for selected results
    options=$@
    for option in ${options[@]}; do
        app_name=$(mas info $option 2> /dev/null | head -1)

        # I don't like this, but couldn't find a good way to grab the error
        # code and also only the first line of output and I didn't want to
        # waste my time here, so I moved on. It's brittle and error prone.
        if [[ $app_name == "No results found" ]]; then
            echo "${red}No app found for id #$option${reset}"
            continue
        fi

        # Default to Yes if the user presses enter without giving an answer:
        if ask "Include $app_name?" Y $option; then
            selected_packages+=("$option")
        fi
    done
}
