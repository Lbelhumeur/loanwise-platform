data "aws_iam_policy_document" "terraform_state" {
  statement {
    sid    = "TerraformStateBucket"
    effect = "Allow"

    actions = [
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::loanwise-platform-tfstate-${var.aws_account_id}"
    ]
  }

  statement {
    sid    = "TerraformStateObjects"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::loanwise-platform-tfstate-${var.aws_account_id}/loanwise-platform/${var.environment}/terraform.tfstate"
    ]
  }
}

resource "aws_iam_role_policy" "terraform_state" {
  name   = "TerraformStateAccess"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.terraform_state.json
}
