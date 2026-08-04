resource "aws_db_instance" "read_replica" {

  count = var.multi_az ? 1 : 0

  identifier = "${local.name}-replica"

  replicate_source_db = aws_db_instance.this.identifier

  instance_class = var.instance_class

  publicly_accessible = false

  auto_minor_version_upgrade = true

  performance_insights_enabled = true

  monitoring_interval = var.monitoring_interval

  tags = local.common_tags
}
