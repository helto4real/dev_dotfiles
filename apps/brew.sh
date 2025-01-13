#!/bin/bash

# Check if Homebrew is installed
if test ! $(which brew); then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Install Homebrew packages

# Install nushell
brew install nushell
