
# Terraform EC2 Instance Provisioning

## Introduction

This Terraform project automates the provisioning of an AWS EC2 instance with a complete networking setup. It modularly creates a VPC, subnet, internet gateway, route table, security group, key pair, and an EC2 instance running Nginx configured via a user data script.

---

## Table of Contents

- [Introduction](#introduction)
- [Architecture](#architecture)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Modules](#modules)
- [Outputs](#outputs)
- [Troubleshooting](#troubleshooting)
- [Contributors](#contributors)
- [License](#license)

---

## Architecture

- A VPC with a CIDR block of `10.0.0.0/24`
- A public subnet (`10.0.0.0/28`)
- An Internet Gateway attached to the VPC
- A route table routing 0.0.0.0/0 via the internet gateway
- An EC2 security group allowing inbound SSH and HTTP traffic
- A Key Pair for instance SSH access
- A `t2.micro` EC2 instance running Ubuntu 22.04 and Nginx

---

## Features

- Modular architecture
- Secure key pair generation
- Public subnet with internet access
- Ingress rules for SSH and HTTP
- User data bootstrap script to install and run Nginx
- Outputs public IP for direct access

---

## Prerequisites

- An [AWS Console account](https://aws.amazon.com/console/) with permissions to manage VPC, EC2, and related services
- AWS access key ID and secret access key
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured:

```bash
# Install AWS CLI (example for Ubuntu/Debian)
sudo apt update && sudo apt install awscli -y

# Configure AWS credentials
aws configure
```


- [Terraform](https://www.terraform.io/downloads.html) ≥ 1.0
- AWS CLI configured (`aws configure`)
- AWS credentials with appropriate IAM permissions
- An SSH client to connect to the instance

---

## Installation

Clone the repository and initialize Terraform:

```bash
git clone <your-repo-url>
cd <project-directory>
terraform init
```

---

## Usage

1. Review and optionally modify values in `main.tf`.
2. Run Terraform:

```bash
terraform plan   # Optional: Review changes
terraform apply  # Provision infrastructure
```

3. After deployment, the public IP of the EC2 instance will be output.

4. To SSH into the instance:

```bash
chmod 600 ec2_instance_key.pem
ssh -i ec2_instance_key.pem ubuntu@<public_ip>
```

5. Access the web server:

Open `http://<public_ip>` in a browser.

---

## Project Structure

```
.
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tf
└── modules/
    ├── VPC/
    ├── INTERNET_GATEWAY/
    ├── PUBLIC_SUBNET/
    ├── ROUTE_TABLE/
    ├── SECURITY_GROUP/
    ├── KEY_PAIR/
    └── EC2/
```

---

## Modules

### VPC
Creates a custom VPC with a configurable CIDR block.

### INTERNET_GATEWAY
Creates and attaches an internet gateway to the VPC.

### PUBLIC_SUBNET
Creates a public subnet in the VPC.

### ROUTE_TABLE
Associates the subnet with a route table that allows internet access.

### SECURITY_GROUP
Creates a security group allowing SSH (22) and HTTP (80) traffic.

### KEY_PAIR
Generates a TLS key pair and stores the private key locally.

### EC2
Launches an EC2 instance with the above configurations and installs Nginx.

---

## Outputs

- `public_ip`: The public IP address of the EC2 instance
- `key_name`: The name of the key pair
- `private_key_path`: Path to the generated `.pem` private key

---

## Troubleshooting

- **Cannot SSH into the instance**
  - Ensure your IP is not blocked and security group allows port 22
  - Check if you are using the correct private key and permissions (`chmod 600`)

- **Nginx not reachable via browser**
  - Verify the instance is running and the user data script completed
  - Check security group inbound rules for port 80

---

## Contributors

This project was created by Syed Saifuddin.

---

## License

This project is licensed under the MIT License. See `LICENSE` file for details.
