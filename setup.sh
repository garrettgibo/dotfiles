#!/bin/bash

# Link neovim init.vim
nvimHome=$HOME/.config/nvim
[ ! -d $nvimHome ] && echo "Creating .config/nvim" && mkdir $nvimHome
[ -f $nvimHome/init.vim ] && echo "Removing previous init" && rm $nvimHome/init.vim
ln nvim/init.vim $nvimHome/init.vim && echo "Linking init.vim"

# Link zsh stuff
zshHome=$HOME/.config/zsh
[ ! -d $zshHome ] && echo "Creating .config/zsh" && mkdir $zshHome
[ -f $zshHome/.zshrc ] && echo "Removing previous .zshrc" && rm $zshHome/.zshrc
[ -f $HOME/.zshenv ] && echo "Removing previous .zshenv" && rm $HOME/.zshenv
ln zsh/zshenv $HOME/.zshenv && echo "Linking .zshenv"
ln zsh/zshrc $zshHome/.zshrc && echo "Linking .zshrc"

# Link zsh stuff
[ -f $Home/.tmux.conf ] && echo "Removing previous tmux.conf" && rm $Home/.tmux.conf
ln tmux/tmux.conf $HOME/.tmux.conf && echo "Linking tmux.conf"
