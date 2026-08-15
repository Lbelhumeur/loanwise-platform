variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "aws_account_id" {
  type      = string
  sensitive = true
}

variable "aws_region" {
  type = string
}

variable "noncurrent_version_retention_days" {
  type    = number
  default = 90

  validation {
    condition     = var.noncurrent_version_retention_days > 0
    error_message = "Retention days must be greater than zero."
  }
}
