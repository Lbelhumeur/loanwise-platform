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

  default_tags {
    tags = {
      Application = "LoanWiseMethod"
      Environment = "dev"
      ManagedBy   = "Terraform"
      Tenant      = "loanwise"
    }
  }
}

module "naming" {
  source       = "../../modules/naming"
  project_name = var.project_name
  environment  = "dev"
  tenant_id    = var.tenant_id
}
