#!/bin/bash

# Check if dotnet is already installed
if dpkg -s dotnet-sdk-9.0 >/dev/null 2>&1; then
    # dotnet is already installed
    return 0
fi
# Add the dotnet backports repository
sudo add-apt-repository -y ppa:dotnet/backports

sudo apt-get install -y \
    dotnet-runtime-8.0 \
    dotnet-sdk-9.0 \
    dotnet-runtime-9.0

# Install dotnet outdated tool
dotnet tool install --global dotnet-outdated-tool

    
# # Install dotnet core debug
#
# # Create a temporary directory
# temp_dir=$(mktemp -d)
#
# # Download netcoredbg
# curl -L https://github.com/Samsung/netcoredbg/releases/download/3.1.2-1054/netcoredbg-linux-amd64.tar.gz -o $temp_dir/netcoredbg.tar.gz
#
# # Extract the package
# tar -xzf $temp_dir/netcoredbg.tar.gz -C $temp_dir
#
# # Copy the package to the right location
# sudo cp -r $temp_dir/netcoredbg /usr/local/bin/netcoredbg
#
# # Make the package executable
# chmod 744 /usr/local/bin/netcoredbg/*
#
# # Clean up
# rm -rf $temp_dir
