#!/bin/sh
#
# Script to select and setup necessary components for the optimal experience.
#

# Source necessary functions
source ./scripts/helpers.sh
source ./scripts/multiselect.sh
source ./scripts/setup_functions.sh

OPTIONS=("zsh" "neovim" "tmux" "extras")
OPTIONS_STRING=$(IFS=\; ; echo "${OPTIONS[*]}")

echo "Select to Setup/Install: "

multiselect SELECTED "$OPTIONS_STRING"

# Call selected setup functions
for i in "${!SELECTED[@]}"; do
  if [ "${SELECTED[$i]}" == "true" ]; then
    case ${OPTIONS[$i]} in
      "zsh")    setup_zsh;;
      "neovim") setup_neovim;;
      "tmux")   setup_tmux;;
      "extras") setup_extras;;
    esac
  fi
done
