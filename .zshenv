# PATH
export PATH="$HOME/.local/bin:$PATH"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# ZSH
export ZSH=$XDG_CONFIG_HOME/oh-my-zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1