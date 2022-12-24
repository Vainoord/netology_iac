# Default region for your account
variable "aws_default_region" {
  default = "eu-central-1"
}

# Your user's access key (not account access_key)
variable "aws_access_key" {
  default = ""
}

# Your user's secret key (not account access_key)
variable "aws_secret_key" {
  default = ""
}

# AMI images id
# ubuntu
variable "aws_ubuntu_ami_id" {
  default = "ami-0caef02b518350c8b"
}
# red hat
variable "aws_redhat_ami_id" {
  default = "ami-0e7e134863fac4946"
}
# amazon
variable "aws_amazon_ami_id" {
  default = "ami-070b208e993b59cea"
}

# Define latest images
# Latest ubuntu image
data "aws_ami" "latest_ubuntu" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}
# Latest ubuntu image
data "aws_ami" "latest_amazon_linux" {
  owners = ["137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

# Default instance for your region
# t2.micro can be used for free in central european region
variable "aws_instance_t2" {
  default = "t2.micro"
}
variable "aws_instance_t3" {
  default = "t3.micro"
}

# Define a zone for subnets in my default region
variable "aws_zone_residence" {
  default = "eu-central-1a"
}

# Define an instance in depends of the current workspace 
locals {
  aws_instance_type_map = {
    #stage = var.aws_instance_t3
    #prod = var.aws_instance_t2
    #default = var.aws_instance_t2
    study-dev-eu-central-vainoord-netology = var.aws_instance_t2
  }

  aws_instance_count_map = {
    #stage = 1
    #prod = 2
    #default = 1
    study-dev-eu-central-vainoord-netology = 1
  }
  aws_instances_list = {
    "t2.micro" = data.aws_ami.latest_amazon_linux.id
    "t3.micro" = data.aws_ami.latest_ubuntu.id
  }
  #aws_instances_ips = {}
}
