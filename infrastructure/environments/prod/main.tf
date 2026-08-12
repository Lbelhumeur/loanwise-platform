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
      Environment = "prod"
      ManagedBy   = "Terraform"
      Tenant      = "loanwise"
    }
  }
}

# Production targets the dedicated LoanWise production AWS account.
# Account IDs and credentials are intentionally not stored in source control.
