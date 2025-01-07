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

##Resources

# "aws_s3_bucket" "Terra_s3_222" {
#  bucket = "terra-dev-buc"

#  tags = {
#    Name        = "Terra_s3_222"
#    Environment = "Dev"
#  }
#}


resource "aws_vpc" "Terravpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "terraVPC"
  }
}

resource "aws_subnet" "Terra_Subnet_pub1" {
  vpc_id     = "${aws_vpc.Terravpc.id}"
  cidr_block = "${var.subnet_pub_1_cidr}"

  tags = {
    Name = "Subnet1_pub"
  }
}

resource "aws_subnet" "Terra_Subnet_pub2" {
  vpc_id     = "${aws_vpc.Terravpc.id}"
  cidr_block = "${var.subnet_pub_2_cidr}"

  tags = {
    Name = "Subnet2_pub"
  }
}

resource "aws_internet_gateway" "IGW_Terra" {
  vpc_id = "${aws_vpc.Terravpc.id}"

  tags = {
    Name = "IGW_Terra"
  }
}


resource "aws_security_group" "vpc_SG" {
  name        = "vpc_SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "${aws_vpc.Terravpc.id}"

  tags = {
    Name = "vpc_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_SG_allow_ssh_http" {
  security_group_id = aws_security_group.vpc_SG.id
  cidr_ipv4         = aws_vpc.Terravpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "vpc_SG_allow_http" {
  security_group_id = aws_security_group.vpc_SG.id
  cidr_ipv4         = aws_vpc.Terravpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.vpc_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "terr_instance" {
  ami           = "${var.instance_ami}" 		# Replace with the desired AMI ID of the region/AZ
  instance_type = "${var.instance_type}"
  count = "${var.instance_count}"					#4 						#This will launch 4 servers with same configuration
  subnet_id= "${aws_subnet.Terra_Subnet_pub1.id}"
  key_name = "${var.instance_key}"
  security_groups = [aws_security_group.vpc_SG.id] ##This is the syntax for calling SG ,don't use interpolation here.
  tags = {
    Name = "Terraform Instance"
  }
}

