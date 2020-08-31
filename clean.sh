#!/bin/bash
#
# Script to select and clean setup
#

# Source necessary functions
. ./scripts/helpers.sh
. ./scripts/multiselect.sh
. ./scripts/clean_functions.sh

OPTIONS=("zsh" "neovim" "tmux" "extras")
OPTIONS_STRING=$(IFS=\; ; echo "${OPTIONS[*]}")

echo "Select to Clean/Remove: "

multiselect selected "$OPTIONS_STRING"

# Call selected clean functions
for i in "${!selected[@]}"; do
  if [ "${selected[$i]}" == "true" ]; then
    case ${OPTIONS[$i]} in
      "zsh")    clean_zsh;;
      "neovim") clean_neovim;;
      "tmux")   clean_tmux;;
      "extras") clean_extras;;
    esac
  fi
done
