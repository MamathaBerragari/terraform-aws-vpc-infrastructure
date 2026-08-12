locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy   = "Terraform"
      Project     = var.project_name
      Environment = var.environment
    }
  )
}
