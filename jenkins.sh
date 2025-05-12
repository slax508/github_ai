#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Java is installed
if command_exists java; then
    echo "Java is already installed."
else
    echo "Java is not installed. Installing Java..."
    sudo apt update
    sudo apt install -y openjdk-17-jdk
fi

# Check if Jenkins is installed
if systemctl list-units --type=service | grep -q jenkins; then
    echo "Jenkins is already installed."
else
    echo "Jenkins is not installed. Installing Jenkins..."
    sudo apt update
    sudo apt install -y curl gnupg2
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
        /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt update
    sudo apt install -y jenkins
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
fi

# Add user 'ubuntu' to the 'jenkins' group
if id -nG ubuntu | grep -qw jenkins; then
    echo "User 'ubuntu' is already in the 'jenkins' group."
else
    echo "Adding user 'ubuntu' to the 'jenkins' group..."
    sudo usermod -aG jenkins ubuntu
fi

# Check if Docker is installed
if command_exists docker; then
    echo "Docker is already installed."
else
    echo "Docker is not installed. Installing Docker..."
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker
fi

# Add user 'ubuntu' to the 'docker' group
if id -nG ubuntu | grep -qw docker; then
    echo "User 'ubuntu' is already in the 'docker' group."
else
    echo "Adding user 'ubuntu' to the 'docker' group..."
    sudo usermod -aG docker ubuntu
fi

# Add user 'jenkins' to the 'docker' group
if id -nG jenkins | grep -qw docker; then
    echo "User 'jenkins' is already in the 'docker' group."
else
    echo "Adding user 'jenkins' to the 'docker' group..."
    sudo usermod -aG docker jenkins
fi

echo "Setup completed. Please log out and log back in for group changes to take effect."
echo "You can access Jenkins at http://localhost:8080"
echo "To unlock Jenkins, run the following command:"
echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
echo "Then, follow the instructions in your web browser."
echo "To start Jenkins, run the following command:"
echo "sudo systemctl start jenkins"
echo "To stop Jenkins, run the following command:"
echo "sudo systemctl stop jenkins"
echo "To restart Jenkins, run the following command:"
echo "sudo systemctl restart jenkins"
echo "To check the status of Jenkins, run the following command:"
echo "sudo systemctl status jenkins"
echo "To check the logs of Jenkins, run the following command:"
echo "sudo journalctl -u jenkins"

# Ensure Java is updated to version 17 if an older version is installed
JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [[ "$JAVA_VERSION" -lt 17 ]]; then
    echo "Updating Java to version 17..."
    sudo apt update
    sudo apt install -y openjdk-17-jdk
else
    echo "Java is already version 17 or newer."
fi