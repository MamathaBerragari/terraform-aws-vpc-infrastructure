resource "aws_db_parameter_group" "this" {

  name   = "${local.name}-parameter-group"

  family = "postgres16"

  description = "Parameter group for ${local.name}"

  parameter {

    name  = "log_connections"

    value = "1"

  }

  parameter {

    name  = "log_disconnections"

    value = "1"

  }

  parameter {

    name  = "log_statement"

    value = "ddl"

  }

  tags = local.common_tags
}
