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
resource "aws_instance" "terr_instance" {
  ami           = "${var.instance_ami}" 	
  instance_type = "${var.instance_type}"
  count = "${var.instance_count}"			
  key_name = "${var.instance_key}"
  tags = {
    Name = "Ter_Inst_${count.index}"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> /tmp/public_ips.txt"
  }
  provisioner "local-exec" {
    command = "echo $FOO $BAR $BAZ >> env_vars.txt"

    environment = {
      FOO = "bar"
      BAR = 1
      BAZ = "true"
    }
  }
  provisioner "local-exec" {
  interpreter = [
    "/usr/bin/python3", "-c"
  ]
  command = "print('HelloWorld')"
  }
   provisioner "local-exec" {
    command = "echo 'Local Provisioner At create stage'"
  }
   provisioner "local-exec" {
     when = destroy
     command = "echo 'Local-Provisioner at Delete'"
  }


}
