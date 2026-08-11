output "environment" {
  value = "dev"
}

output "aws_region" {
  value = var.aws_region
}

output "tenant_id" {
  value = var.tenant_id
}

output "resource_prefix" {
  value = module.naming.prefix
}
