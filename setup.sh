#!/bin/bash

PATH_BASH=/usr/bin/bash
PATH_ZSH=/usr/bin/zsh
CONFIG_OMZ="$HOME/.config/oh-my-zsh"
CONFIG_ZSH="$HOME/.config/zsh"


# COMMANDS
INSTALL="sudo apt install -y"

# Logging wrappers
info() { echo -e "$1\e[0m"; }
action() { echo -e "\e[34m$1\e[0m"; }
success() { echo -e "\e[32m$1\e[0m"; }
warn() { echo -e "\e[33m$1\e[0m"; }
error() { echo -e "\e[31m$1\e[0m"; }

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

install_zsh() {
    action "Checking Zsh"

    if ! command_exists zsh; then
        warn "Zsh not installed"
        $INSTALL zsh
    fi

    success "Zsh installed"
}

install_oh_my_zsh() {
    action "Checking Oh My Zsh"

    if ! [ -d $CONFIG_OMZ ]; then
        warn "Oh My Zsh not installed"
        action "Cloning Oh My Zsh repo"
        git clone https://github.com/ohmyzsh/ohmyzsh.git $CONFIG_OMZ --depth 1
    fi

    success "Oh My Zsh installed to $ZSH"
}

setup_zsh () {
    action "Setting up Zsh configuration"

    info "Copying zshenv to $HOME/.zshenv..."
    cp zsh/zshenv $HOME/.zshenv
    info "done"

    info "Copying zshrc to $CONFIG_ZSH/.zshrc..."
    if ! [ -d $CONFIG_ZSH ]; then
        warn "$CONFIG_ZSH does not exist"
        action "Creating $CONFIG_ZSH"
        mkdir -p $CONFIG_ZSH
    fi
    cp zsh/zshrc $CONFIG_ZSH/.zshrc
    info "done"
}

setup_configs() {
    action "Setting up all user configurations"
    setup_zsh
}

install_zsh
install_oh_my_zsh
setup_configs