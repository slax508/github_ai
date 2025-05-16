#!/bin/bash

# Function to uninstall kubectl
uninstall_kubectl() {
    echo "Uninstalling kubectl..."
    sudo apt-get remove -y kubectl
    sudo apt-get purge -y kubectl
    sudo rm -f /usr/local/bin/kubectl
    sudo rm -rf ~/.kube
    echo "kubectl uninstalled successfully."
}

# Function to install kubectl
install_kubectl() {
    echo "Installing kubectl..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
    echo "kubectl installed successfully."
}

# Main script execution
uninstall_kubectl
install_kubectl