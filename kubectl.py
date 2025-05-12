import os
import subprocess

def run_command(command):
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while executing: {command}")
        print(e)

def install_packages():
    # Update the system
    run_command("sudo yum update -y")

    # Install Docker
    run_command("sudo yum install -y docker")
    run_command("sudo systemctl start docker")
    run_command("sudo systemctl enable docker")

    # Install AWS CLI
    run_command("sudo yum install -y aws-cli")

    # Install kubectl
    run_command("curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.0/2023-08-28/bin/linux/amd64/kubectl")
    run_command("chmod +x ./kubectl")
    run_command("sudo mv ./kubectl /usr/local/bin/")

    # Install eksctl
    run_command("curl -sL https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz | tar xz -C /tmp")
    run_command("sudo mv /tmp/eksctl /usr/local/bin/")

    # Install Java
    run_command("sudo yum install -y java-11-openjdk")

    # Install Jenkins
    run_command("sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo")
    run_command("sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key")
    run_command("sudo yum install -y jenkins")
    run_command("sudo systemctl start jenkins")
    run_command("sudo systemctl enable jenkins")

if __name__ == "__main__":
    install_packages()