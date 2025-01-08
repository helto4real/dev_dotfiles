# Uninstall fzf if it was installed with apt
if dpkg -s fzf >/dev/null 2>&1; then
    _task "Uninstalling fzf"
        _cmd "sudo apt-get remove -y fzf"
    _task_done
fi

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download fzf to .fzf directory
git clone https://github.com/junegunn/fzf.git $HOME/.fzf --depth 1

git clone https://github.com/junegunn/fzf-git.sh.git $HOME/.fzf-git.sh --depth 1

$HOME/.fzf/install --all --no-update-rc --no-zsh --no-fish

