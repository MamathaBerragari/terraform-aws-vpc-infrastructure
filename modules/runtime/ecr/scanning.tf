resource "aws_ecr_registry_scanning_configuration" "this" {
  count = var.enhanced_scanning_enabled ? 1 : 0

  scan_type = var.enhanced_scanning_scan_type

  rule {
    scan_frequency = var.enhanced_scanning_type

    repository_filter {
      filter      = local.repository_name
      filter_type = var.enhanced_scanning_filter_type
    }
  }
}
