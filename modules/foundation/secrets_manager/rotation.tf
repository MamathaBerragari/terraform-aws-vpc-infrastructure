resource "aws_secretsmanager_secret_rotation" "this" {
  count = var.create_rotation ? 1 : 0

  secret_id = aws_secretsmanager_secret.this.id

  rotation_lambda_arn = coalesce(
    var.rotation_lambda_arn,
    "arn:aws:lambda:invalid:000000000000:function:invalid"
  )

  rotation_rules {
    automatically_after_days = var.rotation_automatically_after_days
  }

  lifecycle {
    precondition {
      condition     = var.rotation_lambda_arn != null
      error_message = "rotation_lambda_arn is required when create_rotation is true."
    }
  }
}
