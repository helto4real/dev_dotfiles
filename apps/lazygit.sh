#!/bin/bash

# Check if lazygit is already installed
if [ -x "$(command -v lazygit)" ]; then
    # lazygit is already installed
    return 0
fi

# Create a temporary directory
temp_dir=$(mktemp -d)

# Get latest version information
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')

# Download lazygit to temporary directory
curl -L "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" -o $temp_dir/lazygit.tar.gz
# tar xf $temp_dir/lazygit.tar.gz -C $temp_dir/lazygi
tar -xzf $temp_dir/lazygit.tar.gz -C $temp_dir

# Install lazygit to /usr/local/bin
sudo install $temp_dir/lazygit -D -t /usr/local/bin/

# Clean up
rm -rf $temp_dir
