#!/bin/sh
#
# clean functions
#

XDG_CONFIG_HOME=$HOME/.config

# Install zsh, oh-my-zsh, and clean configs
function clean_zsh {
  pprint title "remove zsh"
  # uninstall zsh
  read -p "Continue (y/n)?" choice
  case "$choice" in 
    y|Y|'' ) ;;
    n|N )    exit;;
    *)       echo "Invalid Selection"; exit;;
  esac

  # clean zsh
  rm -rf $HOME/.oh-my-zsh \
	 $HOME/.zshrc \
	 $HOME/.zshenv \
	 $HOME/.zsh_history \
	 $XDG_CONFIG_HOME/oh-my-zsh \
	 $XDG_CONFIG_HOME/zsh 
  pprint blue "Removing all zsh configs"
}

function clean_neovim {
  pprint title neovim
}

function clean_tmux {
  pprint title tmux
}

function clean_extras {
  pprint title extras
}
