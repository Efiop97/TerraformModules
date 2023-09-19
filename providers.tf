terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "igor-bucket-tf"
    key     = "do-it-right/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

  }
}


provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.common_tags
  }
}
