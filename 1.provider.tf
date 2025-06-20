provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = "<= 1.9.8"
  required_providers {
    aws = {
      version = "<= 6.0.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "sreeterraformbucket"
    key    = "ansible-b43.tfstate"
    region = "us-east-1"
  }
}
