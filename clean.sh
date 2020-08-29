#!/bin/sh
#
# Script to select and clean setup
#

# Source necessary functions
source ./scripts/helpers.sh
source ./scripts/multiselect.sh
source ./scripts/clean_functions.sh

OPTIONS=("zsh" "neovim" "tmux" "extras")
OPTIONS_STRING=$(IFS=\; ; echo "${OPTIONS[*]}")

echo "Select to Clean/Remove: "

multiselect SELECTED "$OPTIONS_STRING"

# Call selected clean functions
for i in "${!SELECTED[@]}"; do
  if [ "${SELECTED[$i]}" == "true" ]; then
    case ${OPTIONS[$i]} in
      "zsh")    clean_zsh;;
      "neovim") clean_neovim;;
      "tmux")   clean_tmux;;
      "extras") clean_extras;;
    esac
  fi
done
