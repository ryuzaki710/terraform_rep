##vars.tf file containing variables only

variable "region_name" {
 
  default = "us-east-1"
}

variable "vpc_cidr" {

  default = "10.0.0.0/16"
}

variable "subnet_pub_1_cidr" {
  
  default = "10.0.1.0/24"  # Corrected subnet CIDR block size
}

variable "subnet_pub_2_cidr" {
  
  default = "10.0.2.0/24"  # Corrected subnet CIDR block size
}

variable "instance_type" {
  
  default = "t2.micro"
}

variable "instance_count" {

  default = 2
}

variable "instance_key" {

  default = "Terraform_instance"
}

variable "instance_ami" {

  default = "ami-01816d07b1128cd2d"  # Replace with the desired AMI ID for your region
}
