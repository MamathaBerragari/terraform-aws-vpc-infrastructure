resource "aws_ecr_registry_scanning_configuration" "this" {
  count = var.enhanced_scanning_enabled ? 1 : 0

  scan_type = "ENHANCED"

  rule {
    scan_frequency = var.enhanced_scanning_type

    repository_filter {
      filter      = local.repository_name
      filter_type = "WILDCARD"
    }
  }
}
