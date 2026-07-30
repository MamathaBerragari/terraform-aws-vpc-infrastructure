data "aws_iam_policy_document" "kms" {
  count = var.create_kms_policy ? 1 : 0

  statement {
    sid       = "KMSKeyAccess"
    effect    = "Allow"
    actions   = var.kms_actions
    resources = var.kms_key_arns
  }
}

resource "aws_iam_policy" "kms" {
  count = var.create_kms_policy ? 1 : 0

  name        = "${var.name_prefix}-kms-policy"
  description = "KMS access policy managed by Terraform"
  policy      = data.aws_iam_policy_document.kms[0].json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name_prefix}-kms-policy"
    }
  )

  lifecycle {
    precondition {
      condition     = length(var.kms_key_arns) > 0
      error_message = "At least one KMS key ARN is required."
    }
  }
}
