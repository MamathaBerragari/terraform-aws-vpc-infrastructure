data "aws_iam_policy_document" "this" {
  count = local.create_resource_policy ? 1 : 0

  source_policy_documents = var.additional_policy_json != null ? [
    var.additional_policy_json
  ] : []

  dynamic "statement" {
    for_each = length(var.allowed_principal_arns) > 0 ? [1] : []

    content {
      sid       = "AllowConfiguredPrincipals"
      effect    = "Allow"
      actions   = var.allowed_principal_actions
      resources = [aws_secretsmanager_secret.this.arn]

      principals {
        type        = "AWS"
        identifiers = var.allowed_principal_arns
      }
    }
  }
}

resource "aws_secretsmanager_secret_policy" "this" {
  count = local.create_resource_policy ? 1 : 0

  secret_arn          = aws_secretsmanager_secret.this.arn
  policy              = data.aws_iam_policy_document.this[0].json
  block_public_policy = var.block_public_policy
}
