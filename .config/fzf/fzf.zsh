FZF_DATA_HOME=$XDG_DATA_HOME/fzf/fzf.git

# Install fzf if not already installed
if [ ! -d $FZF_DATA_HOME ]; 
then
    mkdir -p "$(dirname $FZF_DATA_HOME)"
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZF_DATA_HOME
    $FZF_DATA_HOME/install --xdg --no-key-bindings --no-completion --no-update-rc --no-bash --no-zsh --no-fish
fi

# Setup fzf
if [[ ! "$PATH" == *$FZF_DATA_HOME/bin* ]]; 
then
  PATH="${PATH:+${PATH}:}$FZF_DATA_HOME/bin"
fi

eval "$(fzf --zsh)"