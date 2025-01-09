#!/bin/bash

# Check if k9s is installed
if [ -x "$(command -v k9s)" ]; then
    # k9s is already installed
    return 0
fi

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download version json file
curl -L https://api.github.com/repos/derailed/k9s/releases/latest -o $temp_dir/k9s_latest.json

# Get the version from json file
K9S_VERSION=$(cat $temp_dir/k9s_latest.json | jq -r '.tag_name')

# Download k9s
curl -L https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_Linux_amd64.tar.gz -o $temp_dir/k9s_Linux_amd64.tar.gz

# Extract the tar file
tar -xzf $temp_dir/k9s_Linux_amd64.tar.gz -C $temp_dir

# Copy k9s to /usr/local/bin
sudo cp -f $temp_dir/k9s /usr/local/bin/k9s

# Make k9s executable
sudo chmod +x /usr/local/bin/k9s

# Clean up
rm -rf $temp_dir
