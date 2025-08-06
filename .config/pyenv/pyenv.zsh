export PYENV_ROOT="$HOME/.pyenv"

# Install pyenv if not already installed
if [ ! -d $PYENV_ROOT/bin ]; 
then
    curl https://pyenv.run | bash
fi

export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"