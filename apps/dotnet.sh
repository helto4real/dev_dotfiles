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

    
