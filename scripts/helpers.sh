#!/bin/bash
#
# Helper functions for setup and installer
#


# determine if system is arch debian based
check_system() {
  system_type=$1
  if uname -a | grep arch; then
    system="arch"
  elif uname -a | grep Ubuntu; then
    system="debian"
  fi
  eval "$system_type"="$system"
}


# install packages for following systems:
# - arch based
# - debian based
add_app() {
  check_system system_type
  if [ "$system_type" == "arch" ]; then
    sudo pacman -S "$@"
  elif [ "$system_type" == "debian" ]; then
    sudo apt install -y "$@"
  else
    echo "Unknown system. Cannot install $1"
  fi
}


# pretty print statement with color option
pprint() {
  case $1 in
    title)
      tput setaf $(((RANDOM % 6) + 1))
      figlet "$2";;
    red)
      tput setaf 1 # red
      echo "$2";;
    green)
      tput setaf 2 # green
      echo "$2";;
    yellow)
      tput setaf 3 # yellow
      echo "$2";;
    blue)
      tput setaf 4 # blue
      echo "$2";;
    bold)
      tput bold
      echo "$2";;
  esac
  tput sgr 0;
}

setup_shell() {
	# Prompt for user choice on changing the default login shell
	# pprint yellow
	read -rp "Do you want to change your default shell to zsh? [Y/n]" opt
	case $opt in
		y*|Y*|"") echo "Changing the shell..." ;;
		n*|N*) echo "Shell change skipped."; return ;;
		*) echo "Invalid choice. Shell change skipped."; return ;;
	esac

	zsh=$(which zsh)

	# Actually change the default shell to zsh
	if ! chsh -s "$zsh"; then
		pprint red "chsh command unsuccessful. Change your default shell manually."
	else
		export SHELL="$zsh"
		pprint green "Shell successfully changed to '$zsh'."
	fi

	pprint green "Restart shell to change to zsh"
}

