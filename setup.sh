#!/bin/bash
#
# Script to select and setup necessary components for the optimal experience.
#

# Source necessary functions
. ./scripts/helpers.sh
. ./scripts/multiselect.sh
. ./scripts/setup_functions.sh

OPTIONS=("zsh" "neovim" "tmux" "node" "extras")
OPTIONS_STRING=$(IFS=\; ; echo "${OPTIONS[*]}")

pprint bold "Select to Setup/Install: "

multiselect selected "$OPTIONS_STRING"

# Call selected setup functions
for i in "${!selected[@]}"; do
  if [ "${selected[$i]}" == "true" ]; then
    case ${OPTIONS[$i]} in
      "zsh")    setup_zsh;;
      "neovim") setup_neovim;;
      "tmux")   setup_tmux;;
      "node")   setup_node;;
      "extras") setup_extras;;
    esac
  fi
done

pprint bold "Finished Setup"
