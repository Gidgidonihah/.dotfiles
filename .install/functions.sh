#!/bin/bash
confirm() {
  # call with a prompt string or use a default
  read -r -p "${1:-Are you sure?} [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY])
      true
      ;;
    *)
      false
      ;;
  esac
}

confirm_to_continue() {
  # call with a prompt string or use a default
  MSG="${1:-You must confirm to continue. Continue?}"
  read -r -p "$MSG [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY])
      true
      ;;
    *)
      confirm_to_continue "$MSG"
      ;;
  esac
}

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
cyan=`tput setaf 6`
black=`tput setaf 0`
reset=`tput sgr0`
dim=`tput dim`

enter_to_continue() {
  MSG=$1
  read -r -p "${cyan}$MSG ${black}${dim}(press any key to continue) ${reset}"
}

get_input() {
  MSG=$1
  read -p "$MSG: " NEW_INPUT
  echo $NEW_INPUT
}

get_input_with_default() {
  DEFAULT=$2
  MSG="$1 ($DEFAULT)"
  NEW_INPUT=$(get_input "$MSG")
  LAST_INPUT=${NEW_INPUT:-$DEFAULT}
  echo $LAST_INPUT
}
