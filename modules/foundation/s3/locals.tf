locals {
  bucket_arn = format(
    "arn:%s:s3:::%s",
    data.aws_partition.current.partition,
    var.bucket_name
  )

  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "S3"
    },
    var.tags
  )

  create_bucket_policy = (
    var.enforce_tls ||
    length(var.allowed_principal_arns) > 0 ||
    var.additional_policy_json != null
  )

  principal_policy_resources = (
    length(var.allowed_principal_resources) > 0
    ) ? (
    var.allowed_principal_resources
    ) : [
    local.bucket_arn,
    "${local.bucket_arn}/*"
  ]
}
