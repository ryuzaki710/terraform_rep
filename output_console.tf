#output_demo.tf

#provider "aws" {
#   region     = "eu-central-1"
#   access_key = <YOUR_ACCESS_KEY>
#   secret_key = <YOUR_SECRET_KEY>
#}

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

resource "aws_instance" "ec2_example" {
   
   ami           = "ami-01816d07b1128cd2d"
   instance_type = "t2.micro"
   
   tags = {
           Name = "test - Terraform EC2"
   }
}

 
