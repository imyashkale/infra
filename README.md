# AWS EC2 Kubernetes Cluster with Terraform

## Introduction
This repository contains Terraform code to set up a Kubernetes cluster on AWS EC2.

## Prerequisites
- AWS Account
- Terraform installed

## Architecture Overview
The setup includes two EC2 instances - one master and one worker node, configured to host Kubernetes.

## Repository Structure
- `/main.tf`: Main Terraform configuration file.
- `/variables.tf`: Variable definitions for Terraform.

## Setup and Deployment
1. **AWS Configuration**:
   - Set up AWS CLI and configure credentials.
2. **Terraform Initialization**:
   - Run `terraform init` to initialize the project.
3. **Plan and Apply**:
   - Execute `terraform plan` to review changes.
   - Run `terraform apply` to apply the configuration.

## Usage
- Accessing the cluster: Use `kubectl` to interact with your cluster.
- Kubernetes Dashboard: Steps to access the dashboard.

## Contributing
Contributions are welcome. Please submit a pull request or create an issue for any features or fixes.

## License
[MIT License](LICENSE)
