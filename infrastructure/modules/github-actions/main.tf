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

data "aws_iam_policy_document" "terraform_assume_role" {
  statement {
    sid     = "GitHubActionsCanAssumeTerraform"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    resources = [
      aws_iam_role.terraform.arn
    ]
  }
}

resource "aws_iam_role" "terraform" {
  name = "${var.project_name}-${var.environment}-terraform"

  assume_role_policy = data.aws_iam_policy_document.terraform_trust.json

  tags = {
    Application = "LoanWiseMethod"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tenant      = "loanwise"
    Component   = "TerraformServiceRole"
  }
}

data "aws_iam_policy_document" "terraform_trust" {
  statement {
    sid     = "GitHubActionsAssumeTerraform"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        aws_iam_role.github_actions.arn
      ]
    }
  }
}
