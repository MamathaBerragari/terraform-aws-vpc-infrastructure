resource "aws_db_parameter_group" "this" {
  name = "${local.name}-parameter-group"

  family = var.parameter_group_family

  description = "Parameter group for ${local.name}"

  parameter {
    name  = "log_connections"
    value = var.rds_log_connections
  }

  parameter {
    name  = "log_disconnections"
    value = var.rds_log_disconnections
  }

  parameter {
    name  = "log_statement"
    value = var.rds_log_statement
  }

  tags = local.common_tags
}
