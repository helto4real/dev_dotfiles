#!/bin/bash

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
# Install fzf
$HOME/.fzf/install --all --no-update-rc --no-zsh --no-fish

# Install fzf-git

mkdir -p $HOME/fzf-git
curl -L https://raw.githubusercontent.com/junegunn/fzf-git.sh/refs/heads/main/fzf-git.sh -o $HOME/fzf-git/fzf-git.sh

sudo rm -rf $temp_dir
