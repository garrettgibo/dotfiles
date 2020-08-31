#!/bin/bash
#
# clean s
#

XDG_CONFIG_HOME=$HOME/.config

# Install zsh, oh-my-zsh, and clean configs
clean_zsh() {
  pprint title "remove zsh"
  # uninstall zsh
  read -rp "Remove zsh configs (y/n)?" choice
  case "$choice" in
    y|Y|'' ) ;;
    n|N )    exit;;
    *)       echo "Invalid Selection"; exit;;
  esac

  # TODO remove zsh and oh-my-zsh

  # clean zsh
  rm -rf "$HOME/.oh-my-zsh" \
    "$HOME/.zshrc" \
    "$HOME/.zshenv" \
    "$HOME/.zsh_history" \
    "$XDG_CONFIG_HOME/oh-my-zsh" \
    "$XDG_CONFIG_HOME/zsh"
  pprint blue "Removing all zsh configs"
}

clean_neovim() {
  pprint title neovim
}

clean_tmux() {
  pprint title tmux
}

clean_extras() {
  pprint title extras
}
