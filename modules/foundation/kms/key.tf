resource "aws_kms_key" "this" {
  description                        = var.description
  deletion_window_in_days            = var.deletion_window_in_days
  enable_key_rotation                = var.enable_key_rotation
  is_enabled                         = var.is_enabled
  multi_region                       = var.multi_region
  key_usage                          = var.key_usage
  customer_master_key_spec           = var.customer_master_key_spec
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check

  policy = var.policy_json != null ? (
    var.policy_json
    ) : (
    data.aws_iam_policy_document.key.json
  )

  tags = merge(
    local.common_tags,
    {
      Name = local.alias_name
    }
  )

  lifecycle {
    precondition {
      condition = (
        !var.enable_key_rotation ||
        var.customer_master_key_spec == "SYMMETRIC_DEFAULT"
      )
      error_message = "Automatic rotation requires SYMMETRIC_DEFAULT."
    }
  }
}
