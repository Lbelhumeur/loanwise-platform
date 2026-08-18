variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "repository" {
  type = string
}

variable "aws_account_id" {
  type      = string
  sensitive = true
}
