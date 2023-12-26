terraform {
  backend "s3" {
    bucket         = "imyashkale-infra-terraform-state"
    key            = "terraform-state-file"             # Path to the state file within the bucket
    region         = "ap-south-1"                       # Region of the S3 bucket
    dynamodb_table = "imyashkale-infra-terraform-state" # DynamoDB table name for state locking
    encrypt        = true                               # Enable encryption for the state file
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "master-node" {
  ami             = var.ami
  instance_type   = "t3.small"
  key_name        = var.key_name
  security_groups = [aws_security_group.master-node.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo hostnamectl set-hostname master
              EOF

  tags = {
    Name = "kubernetes - Master Node"
  }
}

resource "aws_instance" "worker-node" {
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.worker-node.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo hostnamectl set-hostname worker-node-01
              EOF

  tags = {
    Name = "kubernetes - Worker Node"
  }
}

resource "aws_security_group" "master-node" {
  name        = "Master Node"
  description = "Master Node"

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubernetes API Server
  ingress {
    description = "Kubernetes API Server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # etcd server client API
  ingress {
    description = "ETCd server client API"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubelet API
  ingress {
    description = "Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "kubernetes - Master Node"
  }
}

resource "aws_security_group" "worker-node" {
  name        = "Worker Node"
  description = "Worker Node"

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Kubernetes API Server
  ingress {
    description     = "Kubernetes API Server"
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    security_groups = [aws_security_group.master-node.id]
  }

  # etcd server client API
  ingress {
    description     = "ETCd server client API"
    from_port       = 2379
    to_port         = 2380
    protocol        = "tcp"
    security_groups = [aws_security_group.master-node.id]
  }

  # Kubelet API
  ingress {
    description     = "Kubelet API"
    from_port       = 10250
    to_port         = 10250
    protocol        = "tcp"
    security_groups = [aws_security_group.master-node.id]
  }

  # NodePort Services
  ingress {
    description = "NodePort Services"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "kubernetes - Worker Node"
  }
}