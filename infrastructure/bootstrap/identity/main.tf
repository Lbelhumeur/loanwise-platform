terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
}

module "github_actions" {
  source = "../../modules/github-actions"

  project_name   = var.project_name
  environment    = "dev"
  repository     = var.repository
  aws_account_id = var.aws_account_id
  aws_region     = var.aws_region
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_account_id" {
  type      = string
  sensitive = true
}

variable "project_name" {
  type    = string
  default = "loanwise-platform"
}

variable "repository" {
  type    = string
  default = "Lbelhumeur/loanwise-platform"
}
