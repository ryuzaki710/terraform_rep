##Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

locals {
  instance_name = "${terraform.workspace}-instance" 
}

variable "instance_type" {
  type = string
  description = "Type of instance to launch"
}

resource "aws_instance" "ec2_example" {

    ami = "ami-01816d07b1128cd2d" 

    instance_type = var.instance_type

    tags = {
      Name = local.instance_name
    }
}

