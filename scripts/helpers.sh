#!/bin/sh
#
# Helper functions for setup and installer
# 


# determine if system is arch debian based
function check_system {
  local system_type=$1
  if [ -n "$(uname -a | grep arch)" ]; then
    system="arch"
  elif [ -f "$(uname -a | grep Ubuntu)" ]; then
    system="debian"
  fi
  eval $system_type=$system
}


# install packages for following systems:
# - arch based
# - debian based
function install {
  check_system SYSTEM_TYPE
  if [ $SYSTEM_TYPE == "arch" ]; then
    sudo pacman -S "$@"
  elif [ $SYSYTEM_TYPE == "debian" ]; then
    sudo apt install -y "$@"
  else
    echo "Unknown system. Cannot install $1"
  fi
}


# pretty print statement with color option
function pprint {
  case $1 in 
    title)
      tput setaf $(((RANDOM % 6) + 1))
      figlet $2;;
    red)
      tput setaf 1 # red
      echo $2;;
    green)
      tput setaf 2 # green
      echo $2;;
    yellow)
      tput setaf 3 # yellow
      echo $2;;
    blue)
      tput setaf 4 # blue
      echo $2;;
  esac
  tput sgr 0;
}
