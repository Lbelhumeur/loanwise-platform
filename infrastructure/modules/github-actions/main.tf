data "tls_certificate" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.github_actions.certificates[0].sha1_fingerprint
  ]

  tags = {
    Application = "LoanWiseMethod"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tenant      = "loanwise"
    Component   = "GitHubActionsOIDC"
  }
}

data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    sid     = "GitHubActionsAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github_actions.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.repository}:environment:${var.environment}"
      ]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name = "${var.project_name}-${var.environment}-github-actions"

  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  tags = {
    Application = "LoanWiseMethod"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tenant      = "loanwise"
    Component   = "GitHubActionsDeployment"
  }
}
