#!/usr/bin/env bash

addToPath /usr/local/go/bin
#addToPath $GOPATH/bin
#addToPath $HOME/go/bin
addToPath $HOME/.dotfiles/bin
addToPath $HOME/.cargo/bin
# export DOTNET_ROOT=$HOME/.dotnet
# addToPath $HOME/.dotnet
# addToPath $HOME/.dotnet/tools

addToPathFront $HOME/.local/bin

addToPath $HOME/.fzf/bin

# ccache
#addToPathFront /usr/lib/ccache
