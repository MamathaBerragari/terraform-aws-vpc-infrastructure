locals {
  name = "${var.project_name}-${var.environment}-vpce"

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "foundation-vpc-endpoint"
    }
  )
}
