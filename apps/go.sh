#!/bin/bash

GOVERSION=1.23.4

# return if go version is already installed
if [ "$(go version | cut -d ' ' -f 3)" == "$GOVERSION" ]; then
    return 0
fi

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download neovim appimage and copy to /usr/local/bin
curl -L https://go.dev/dl/go${GOVERSION}.linux-amd64.tar.gz -o $temp_dir/go.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $temp_dir/go.tar.gz
# Clean up
rm -rf $temp_dir
