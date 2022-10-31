# Default region for your account
variable "aws_region" {
  default = "eu-central-1"
}

# Your account's access key
variable "aws_access_key" {
  default = ""
}

# Your account's secret key
variable "aws_secret_key" {
  default = ""
}

# AMI image id
variable "aws_ami_id" {
  default = "ami-0caef02b518350c8b"
}

# Default instance for your region
# t2.micro can be used for free in central european region
variable "aws_instance_type" {
  default = "t2.micro"
}

# Define a zone for subnets in my default region
variable "aws_zone_residence" {
  default = "eu-central-1a"
}
