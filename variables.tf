variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "ami" {
  description = "Ubuntu 22.04 LTS AMI"
  default     = "ami-03f4878755434977f"
}

variable "key_name" {
  default     = "mackbook-pro"
  description = "Key name for EC2 instances"
}

variable "local_key_path" {
  default     = "~/mackbook-pro.pem"
  description = "Local Key Path"
}
