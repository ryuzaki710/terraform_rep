variable "region_name" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_key" {
  type    = string
  default = "Terraform_instance"
}

variable "instance_ami" {
  type    = string
  default = "ami-05576a079321f21f8"  # Replace with the desired AMI ID for your region
}
