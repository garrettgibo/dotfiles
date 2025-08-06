# Install oh-my-posh if not already installed
if ! command -v oh-my-posh >/dev/null 2>&1;
then
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

eval "$(oh-my-posh init zsh --config "$OMP_HOME/omp.toml")"