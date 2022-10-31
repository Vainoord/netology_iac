# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "aws_test_ec2" {
  ami = var.aws_ami_id

  instance_type = var.aws_instance_type

  tags = {
    Name = "Ubuntu_ec2"
  }
  
  network_interface {
    network_interface_id = aws_network_interface.test_iface.id
    device_index = 0
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}
