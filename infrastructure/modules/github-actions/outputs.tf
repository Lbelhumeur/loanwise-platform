output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.github_actions.arn
}

output "deployment_role_name" {
  value = aws_iam_role.github_actions.name
}

output "deployment_role_arn" {
  value = aws_iam_role.github_actions.arn
}
