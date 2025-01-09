#!/bin/bash

# Check if tmux correct version is installed
if [ "$(tmux -V | cut -c 6-)" == "3.5a" ]; then
    # tmux version 3.5a is already installed
    return 0
fi

# Install dependencies
sudo apt-get install -y libevent-dev ncurses-dev bison pkg-config

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download tmux
curl -L https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz -o $temp_dir/tmux-3.5a.tar.gz

# Extract the tar file
tar -xzf $temp_dir/tmux-3.5a.tar.gz -C $temp_dir

# Change to the tmux directory
pushd "$temp_dir/tmux-3.5a" 2>&1 > /dev/null

# Configure, make, and install
./configure
make
sudo make install

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Activate the tmux plugin manager and install plugins
tmux source $HOME/.config/tmux/tmux.conf
tmux start-server
tmux new-session -d
sleep 1
$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

# Clean up
rm -rf $temp_dir

popd
