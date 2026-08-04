resource "aws_db_instance" "this" {

  identifier = local.name

  engine = var.engine

  engine_version = var.engine_version

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  max_allocated_storage = var.max_allocated_storage

  db_name = var.database_name

  username = var.username

  password = var.password

  port = var.port

  multi_az = var.multi_az

  storage_encrypted = var.storage_encrypted

  kms_key_id = var.kms_key_id

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  parameter_group_name = aws_db_parameter_group.this.name

  backup_retention_period = var.backup_retention_period

  performance_insights_enabled = var.performance_insights_enabled

  monitoring_interval = var.monitoring_interval

  deletion_protection = var.deletion_protection

  iam_database_authentication_enabled = true

  skip_final_snapshot = false

  apply_immediately = false

  publicly_accessible = false

  copy_tags_to_snapshot = true

  auto_minor_version_upgrade = true

  tags = local.common_tags
}
