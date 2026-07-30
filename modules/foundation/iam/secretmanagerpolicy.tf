data "aws_iam_policy_document" "secrets_manager" {
  count = var.create_secrets_manager_policy ? 1 : 0

  statement {
    sid       = "SecretsManagerAccess"
    effect    = "Allow"
    actions   = var.secrets_manager_actions
    resources = var.secret_arns
  }
}

resource "aws_iam_policy" "secrets_manager" {
  count = var.create_secrets_manager_policy ? 1 : 0

  name        = "${var.name_prefix}-secrets-manager-policy"
  description = "Secrets Manager access policy managed by Terraform"
  policy      = data.aws_iam_policy_document.secrets_manager[0].json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name_prefix}-secrets-manager-policy"
    }
  )

  lifecycle {
    precondition {
      condition     = length(var.secret_arns) > 0
      error_message = "At least one Secrets Manager secret ARN is required."
    }
  }
}
