##Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
resource "aws_vpc" "Terravpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraVPC_Lockupdated"
  }
}
terraform {
  backend "s3" {
    bucket = "terraform-backend-demo-710"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-s3-backend-demo" 
  }
}

