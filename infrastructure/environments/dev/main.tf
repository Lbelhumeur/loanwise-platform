terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Application = "LoanWiseMethod"
      Environment = "dev"
      ManagedBy = "Terraform"
    }
  }
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}