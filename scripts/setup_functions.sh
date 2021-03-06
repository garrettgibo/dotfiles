#!/bin/bash
#
# setup functions
#
XDG_CONFIG_HOME=$HOME/.config


# Install zsh, oh-my-zsh, and setup configs
setup_zsh() {
  ZDOTDIR=$XDG_CONFIG_HOME/zsh
  ZSH=$XDG_CONFIG_HOME/oh-my-zsh
  ZSH_CUSTOM=$ZSH/custom

  pprint title zsh

  # install zsh
  if ! type zsh >> /dev/null 2>&1; then
    pprint blue "Installing zsh"
    add_app zsh
  else
    pprint yellow "zsh already installed"
  fi

  # Remove existing .zsh* configs
  [ -d "$ZDOTDIR" ] && rm -rf "$ZDOTDIR"
  [ -f "$HOME/.zshenv" ] && rm "$HOME/.zshenv"

  # Link .zsh* configs to dotfiles
  mkdir "$ZDOTDIR" && pprint blue "- Creating $ZDOTDIR"

  ln shell/zsh/zshenv "$HOME/.zshenv" && \
    pprint blue "- Linking shell/zsh/zshenv to $HOME/.zshenv"

  ln shell/zsh/zshrc "$ZDOTDIR/.zshrc" && \
    pprint blue "- Linking shell/zsh/zshrc to $ZDOTDIR/.zshrc"

  ln shell/aliases "$ZDOTDIR/.zsh_aliases" && \
    pprint blue "- Linking shell/aliases to $ZDOTDIR/.zsh_aliases"

  # set env vars for zsh
  # shellcheck source=/dev/null
  . "$HOME/.zshenv"

  # Install Oh-My-Zsh
  if [ ! -d "$HOME/.oh-my-zsh" ] &&  [ ! -d "$ZSH" ]; then
    pprint blue "Installing Oh-My-Zsh"
    omzinstall=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    curl -Lo install.sh "$omzinstall" >> /dev/null 2>&1
    sh install.sh --unattended >> /dev/null 2>&1 && rm install.sh
    rm "$HOME/.zshrc" # installer creates extra template zshrc
  else
    pprint yellow "Oh-My-Zsh already installed"
  fi

  # Install Oh-My-Zsh Plugins
  pprint blue "Installing Oh-My-Zsh Plugins"

  # zsh-syntax-highligting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" >> /dev/null 2>&1

  # zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions" >> /dev/null 2>&1

  setup_shell
}

setup_neovim() {
  XDG_CONFIG_HOME=$HOME/.config
  NVIM=$XDG_CONFIG_HOME/nvim

  pprint title neovim

  # install neovim
  if ! nvim -v >> /dev/null 2>&1; then
    pprint blue "Installing neovim"
    add_app neovim
  else
    pprint yellow "neovim already installed"
  fi

  # Remove existing nvim configs
  [ -d "$NVIM" ] && rm -rf "$NVIM"

  # Link .zsh* configs to dotfiles
  mkdir "$NVIM" && pprint blue "- Creating $NVIM"
  ln nvim/init.vim "$NVIM/init.vim" && \
    pprint blue "- Linking nvim/init.vim to $NVIM/init.vim"

  # installing fzf and ripgrep
  if ! fzf --version >> /dev/null 2>&1; then
    pprint blue "Installing fzf"
    add_app fzf
  fi
  if ! rg -v >> /dev/null 2>&1; then
    pprint blue "Installing ripgrep"
    add_app fzf ripgrep
  fi

  pprint blue "Installing vim-plug"
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  sh "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim >> /dev/null 2>&1
  pprint red "Run 'PlugInstall' inside vim to setup plugins"
}

setup_tmux() {
  pprint title tmux
  # TODO:
  # install tmux
  # - link tmux.conf
}

setup_node() {
  pprint title node

  if ! node -v >> /dev/null 2>&1; then
    pprint blue "Installing nodejs"
    add_app nodejs
  else
    pprint yellow "nodejs already installed"
  fi

  if ! npm -v >> /dev/null 2>&1; then
    pprint blue "Installing npm"
    add_app npm
  else
    pprint yellow "npm already installed"
  fi

  if ! yarn -v >> /dev/null 2>&1; then
    pprint blue "Installing yarn"
    add_app yarn
  else
    pprint yellow "yarn already installed"
  fi

	read -rp "Do you want to install some node packages? [Y/n]" opt
	case "$opt" in
		y*|Y*|"") ;;
		n*|N*) return;;
		*) return;;
	esac

  # node packages to install
  pprint blue "Installing neovim from npm"
  sudo npm add_app -g neovim
}

setup_extras() {
  pprint title extras
  echo "setting up extra applications";
  # TODO create multiselections for extra applications to install
  # - hub
  # - tig
  # - broot
  # - exa
  # - shellcheck
}
