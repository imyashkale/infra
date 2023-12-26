terraform {
  backend "s3" {
    bucket         = "imyashkale-infra-terraform-state"
    key            = "terraform-state-file"            # Path to the state file within the bucket
    region         = "ap-south-1"                 # Region of the S3 bucket
    dynamodb_table = "imyashkale-infra-terraform-state"   # DynamoDB table name for state locking
    encrypt        = true                        # Enable encryption for the state file
  }
}

provider "aws" {
  region = "ap-south-1" 
}

resource "aws_instance" "master-node" {
  ami           = var.ami
  instance_type = "t3.small"
  key_name      = var.key_name
  security_groups = [aws_security_group.master-node.name]

  tags = {
    Name = "kubernetes - Master Node"
  }
}

resource "aws_instance" "worker-node" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.worker-node.name]

  tags = {
    Name = "kubernetes - Worker Node"
  }
}

resource "aws_security_group" "master-node" {
  name        = "Master Node"
  description = "Master Node"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "worker-node" {
  name        = "Worker Node"
  description = "Worker Node" 

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}