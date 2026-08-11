variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "tenant_id" {
  type = string
}

locals {
  prefix = "${var.project_name}-${var.environment}"
}

output "prefix" {
  value = local.prefix
}

output "tenant_id" {
  value = var.tenant_id
}
