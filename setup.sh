#!/bin/sh
#
# Script to select and setup necessary components for the optimal experience.
#

# Source necessary functions
source ./scripts/multiselect.sh
source ./scripts/

OPTIONS=("Zsh" "Neovim" "Tmux")
OPTIONS_STRING=$(IFS=\; ; echo "${OPTIONS[*]}")

multiselect SELECTED "$OPTIONS_STRING"

# Call selected setup functions
for i in "${!SELECTED[@]}"; do
  if [ "${SELECTED[$i]}" == "true" ]; then
    case ${OPTIONS[$i]} in
      "Zsh") 
        echo "Setting Up Zsh"
	echo "TODO: Call zsh setup";;
      "Neovim") 
        echo "Setting Up Neovim"
	echo "TODO: Call Neovim setup";;
      "Tmux") 
        echo "Setting Up Tmux"
	echo "TODO: Call zsh setup";;
    esac
  fi
done

# Link neovim init.vim
# nvimHome=$HOME/.config/nvim
# [ ! -d $nvimHome ] && echo "Creating .config/nvim" && mkdir $nvimHome
# [ -f $nvimHome/init.vim ] && echo "Removing previous init" && rm $nvimHome/init.vim
# ln nvim/init.vim $nvimHome/init.vim && echo "Linking init.vim"

#===============================
# ZSH Setup
#===============================
# echo "Install/setup ZSH? [Y,n]"
# read input
# if [[ $input == "Y" || $input == "y" || ]]
# ZSHHOME=$HOME/.config/zsh
# [ ! -d $ZSHHOME ] && echo "Adding zsh config directory at $ZSHHOME" && mkdir $ZSHHOME
# [ -f $ZSHHOME/.zshrc ] && echo "Removing previous .zshrc" && rm $ZSHHOME/.zshrc
# [ -f $HOME/.zshenv ] && echo "Removing previous .zshenv" && rm $HOME/.zshenv
# ln zsh/zshenv $HOME/.zshenv && echo "Linking .zshenv"
# ln zsh/zshrc $ZSHHOME/.zshrc && echo "Linking .zshrc"

# Link zsh stuff
# [ -f $Home/.tmux.conf ] && echo "Removing previous tmux.conf" && rm $Home/.tmux.conf
# ln tmux/tmux.conf $HOME/.tmux.conf && echo "Linking tmux.conf"


