locals {
  name = "${var.environment}-${var.db_identifier}"

  common_tags = merge(
    {
      Environment = var.environment
      Terraform   = "true"
      Module      = "runtime-rds"
    },
    var.tags
  )

  secret_name = "${local.name}-credentials"
}
