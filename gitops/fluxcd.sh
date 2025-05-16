#!/bin/bash
set -e

# Install prerequisites
sudo apt-get update
sudo apt-get install -y curl gnupg lsb-release

# Add FluxCD GPG key and repository
curl -s https://fluxcd.io/install.sh | sudo bash

# Verify installation
flux --version