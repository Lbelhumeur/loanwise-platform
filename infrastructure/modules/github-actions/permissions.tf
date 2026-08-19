data "aws_iam_policy_document" "github_actions" {
  statement {
    sid       = "AssumeTerraformServiceRole"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.terraform.arn]
  }
}

resource "aws_iam_role_policy" "github_actions" {
  name   = "TerraformStateAccess"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.github_actions.json
}

data "aws_iam_policy_document" "terraform_service" {
  statement {
    sid    = "TerraformStateBucket"
    effect = "Allow"

    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::loanwise-platform-tfstate-${var.aws_account_id}"
    ]
  }

  statement {
    sid    = "TerraformStateObjects"
    effect = "Allow"

    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::loanwise-platform-tfstate-${var.aws_account_id}/loanwise-platform/${var.environment}/terraform.tfstate",
      "arn:aws:s3:::loanwise-platform-tfstate-${var.aws_account_id}/loanwise-platform/${var.environment}/terraform.tfstate.tflock"
    ]
  }

  statement {
    sid    = "DevS3Resources"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${var.project_name}-${var.environment}-*",
      "arn:aws:s3:::${var.project_name}-${var.environment}-*/*"
    ]
  }

  statement {
    sid    = "DevCloudTrail"
    effect = "Allow"

    actions = [
      "cloudtrail:AddTags",
      "cloudtrail:CreateTrail",
      "cloudtrail:DeleteTrail",
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetEventSelectors",
      "cloudtrail:GetTrail",
      "cloudtrail:GetTrailStatus",
      "cloudtrail:ListTags",
      "cloudtrail:PutEventSelectors",
      "cloudtrail:RemoveTags",
      "cloudtrail:StartLogging",
      "cloudtrail:StopLogging",
      "cloudtrail:UpdateTrail"
    ]

    resources = [
      "arn:aws:cloudtrail:${var.aws_region}:${var.aws_account_id}:trail/${var.project_name}-${var.environment}"
    ]
  }

  statement {
    sid    = "DevGuardDuty"
    effect = "Allow"

    actions = [
      "guardduty:CreateDetector",
      "guardduty:DeleteDetector",
      "guardduty:GetDetector",
      "guardduty:ListDetectors",
      "guardduty:TagResource",
      "guardduty:UntagResource",
      "guardduty:UpdateDetector"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "terraform_service" {
  name   = "DevTerraformServiceAccess"
  role   = aws_iam_role.terraform.id
  policy = data.aws_iam_policy_document.terraform_service.json
}
