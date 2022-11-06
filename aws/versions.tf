terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  ###
  # Using the s3 backend
  ###
  backend "s3" {
    bucket = "vainoord-s3-bucket"
    encrypt = true
    key = "netology/terraform.tfstate"
    region = "eu-central-1"
  }
}

