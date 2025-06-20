provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = "<= 1.12.5"
  required_providers {
    aws = {
      version = "<= 6.0.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "ansiblepurpose"
    key    = "space_b43.tfstate"
    region = "us-east-1"
  }
}
