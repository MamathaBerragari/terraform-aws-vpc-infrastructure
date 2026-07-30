data "aws_iam_policy_document" "this" {
  count = local.create_bucket_policy ? 1 : 0

  source_policy_documents = var.additional_policy_json != null ? [
    var.additional_policy_json
  ] : []

  dynamic "statement" {
    for_each = var.enforce_tls ? [1] : []

    content {
      sid    = "DenyInsecureTransport"
      effect = "Deny"

      principals {
        type        = "*"
        identifiers = ["*"]
      }

      actions = ["s3:*"]

      resources = [
        local.bucket_arn,
        "${local.bucket_arn}/*"
      ]

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = ["false"]
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.allowed_principal_arns) > 0 ? [1] : []

    content {
      sid       = "AllowConfiguredPrincipals"
      effect    = "Allow"
      actions   = var.allowed_principal_actions
      resources = local.principal_policy_resources

      principals {
        type        = "AWS"
        identifiers = var.allowed_principal_arns
      }
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = local.create_bucket_policy ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this[0].json

  depends_on = [
    aws_s3_bucket_public_access_block.this
  ]
}
