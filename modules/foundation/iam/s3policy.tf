data "aws_iam_policy_document" "s3" {
  count = var.create_s3_policy ? 1 : 0

  dynamic "statement" {
    for_each = length(var.s3_bucket_arns) > 0 ? [1] : []

    content {
      sid       = "S3BucketAccess"
      effect    = "Allow"
      actions   = var.s3_bucket_actions
      resources = var.s3_bucket_arns
    }
  }

  dynamic "statement" {
    for_each = length(var.s3_object_arns) > 0 ? [1] : []

    content {
      sid       = "S3ObjectAccess"
      effect    = "Allow"
      actions   = var.s3_object_actions
      resources = var.s3_object_arns
    }
  }
}

resource "aws_iam_policy" "s3" {
  count = var.create_s3_policy ? 1 : 0

  name        = "${var.name_prefix}-s3-policy"
  description = "S3 access policy managed by Terraform"
  policy      = data.aws_iam_policy_document.s3[0].json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name_prefix}-s3-policy"
    }
  )

  lifecycle {
    precondition {
      condition = (
        length(var.s3_bucket_arns) > 0 ||
        length(var.s3_object_arns) > 0
      )
      error_message = "At least one S3 bucket ARN or object ARN is required."
    }
  }
}
