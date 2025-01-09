#!/bin/bash

# Check if kubectl is installed
if [ -x "$(command -v kubectl)" ]; then
    # kubectl is already installed
    return 0
fi

K8S_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download kubectl
curl -L https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/amd64/kubectl -o $temp_dir/kubectl

# Download checksum file
curl -L https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/amd64/kubectl.sha256 -o $temp_dir/kubectl.sha256

# Get the checksum
CHECKSUM=$(echo "$(cat $temp_dir/kubectl.sha256)")

CALCULATED_CHECKSUM=$(sha256sum $temp_dir/kubectl | awk '{print $1}')

if [ "$CHECKSUM" != "$CALCULATED_CHECKSUM" ]; then
    echo "Checksums do not match. Exiting..."
    exit 1
fi

# Delete existing kubectl in /usr/local/bin if it exists
if [ -f /usr/local/bin/kubectl ]; then
    sudo rm /usr/local/bin/kubectl
fi

# Copy kubectl to /usr/local/bin
sudo cp -f $temp_dir/kubectl /usr/local/bin/kubectl

# Make kubectl executable
sudo chmod +x /usr/local/bin/kubectl

# Copy the configuration file to the user's home directory
mkdir -p ~/.kube
cp -i $DOTFILES_DIR/config/files/k8s/config $HOME/.kube/config
# Use ansible to decrypt the file
ansible-vault decrypt $HOME/.kube/config --vault-password-file $VAULT_SECRET

# check if kubeconfig returns version and return error if not
if ! kubectl version --client; then
    echo "kubectl version failed. Exiting..."
    exit 1
fi

# Clean up
rm -rf $temp_dir
