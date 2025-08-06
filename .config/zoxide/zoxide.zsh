# Install zoxide if not already installed
if ! command -v zoxide >/dev/null 2>&1;
then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

eval "$(zoxide init --cmd cd zsh)"