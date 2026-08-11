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

variable "tenant_id" {
  type    = string
  default = "loanwise"
}
