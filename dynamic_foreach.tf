##test.tf file 

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
  region = "${var.region_name}"
}

resource "aws_vpc" "Terravpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "terraVPC"
  }
}

variable "dyn_inbound"{
	type=map(object({
		
		port=number
		protocol=string 
		cidr_blocks=list(string)
	})) 
	
	default = {

		"80"={
			port=80
			protocol="tcp"
			cidr_blocks=["0.0.0.0/0"]
		}

		"443"={
			port=443
			protocol="tcp"
			cidr_blocks=["0.0.0.0/0"]
		}
	}
	
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.Terravpc.id

  dynamic ingress {

  for_each = var.dyn_inbound 
  content {
	
			description = "TLS from VPC"
			from_port   = ingress.value.port
			to_port     = ingress.value.port
			protocol    = ingress.value.protocol
			cidr_blocks = ingress.value.cidr_blocks
			
  }
  }
  
#  ingress {
#	description = "TLS from VPC"
#			from_port   = 80
#			to_port     = 80
#			protocol    = "tcp"
#			cidr_blocks = []
#			
#    }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_tls"
  }
}

