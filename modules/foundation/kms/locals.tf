locals {
  alias_name = startswith(var.alias_name, "alias/") ? (
    var.alias_name
    ) : (
    "alias/${var.alias_name}"
  )

  account_root_arn = format(
    "arn:%s:iam::%s:root",
    data.aws_partition.current.partition,
    data.aws_caller_identity.current.account_id
  )

  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "KMS"
    },
    var.tags
  )
}
