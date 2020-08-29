#!/bin/sh
#
# setup functions
#
XDG_CONFIG_HOME=$HOME/.config

# Install zsh, oh-my-zsh, and setup configs
function setup_zsh {
  ZDOTDIR=$XDG_CONFIG_HOME/zsh
  ZSH=$XDG_CONFIG_HOME/oh-my-zsh
  ZSH_CUSTOM=$ZSH/custom

  pprint title zsh

  # install zsh
  if [ ! zsh -v &> /dev/null ]; then
    pprint blue "Installing zsh"
    install zsh
  else
    pprint yellow "zsh already installed"
  fi

  # Remove existing .zsh* configs
  [ -d $ZDOTDIR ] && \
    rm -rf $ZDOTDIR
  [ -f $HOME/.zshenv ] && \
    rm $HOME/.zshenv

  # Link .zsh* configs to dotfiles
  mkdir $ZDOTDIR && \
    pprint blue "- Creating $ZDOTDIR"
  ln shell/zsh/zshenv $HOME/.zshenv && \
    pprint blue "- Linking shell/zsh/zshenv to $HOME/.zshenv"
  ln shell/zsh/zshrc $ZDOTDIR/.zshrc && \
    pprint blue "- Linking shell/zsh/zshrc to $ZDOTDIR/.zshrc"
  ln shell/aliases $ZDOTDIR/.zsh_aliases && \
    pprint blue "- Linking shell/aliases to $ZDOTDIR/.zsh_aliases"

  # set env vars for zsh
  source $HOME/.zshenv

  # Install Oh-My-Zsh
  if [ ! -d $HOME/.oh-my-zsh -a ! -d $ZSH ]; then
    pprint blue "Installing Oh-My-Zsh"
    curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh &> /dev/null
    sh install.sh --unattended &> /dev/null && rm install.sh
    rm $HOME/.zshrc # installer creates extra template zshrc
  else
    pprint yellow "Oh-My-Zsh already installed"
  fi

  # Install Oh-My-Zsh Plugins
  pprint blue "Installing Oh-My-Zsh Plugins"
  # zsh-syntax-highligting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    $ZSH_CUSTOM/plugins/zsh-syntax-highlighting &> /dev/null
  # zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    $ZSH_CUSTOM/plugins/zsh-autosuggestions &> /dev/null

  pprint green "F I N I S H E D  Z S H"
}

function setup_neovim {
  pprint title neovim
  # TODO:
  # - install neovim
  # - link init.vim
}

function setup_tmux {
  pprint title tmux
  # TODO: 
  # install tmux
  # - link tmux.conf
}

function setup_extras {
  pprint title extras
  echo "setting up extra applications";
  # TODO create multiselections for extra applications to install
  # - hub
  # - tig
  # - broot
  # - exa
}
