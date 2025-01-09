#!/bin/bash

# Check if helm is already installed
if [ -x "$(command -v helm)" ]; then
    # helm is already installed
    return 0
fi

# Run the install script
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash


