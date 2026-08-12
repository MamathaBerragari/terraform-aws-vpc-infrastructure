resource "aws_db_instance" "this" {
  identifier = local.name

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type

  db_name  = var.database_name
  username = var.master_username

  port = var.port

  multi_az = var.multi_az

  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id

  manage_master_user_password = true

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  parameter_group_name = aws_db_parameter_group.this.name

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  performance_insights_enabled = var.performance_insights_enabled

  monitoring_interval = var.monitoring_interval

  monitoring_role_arn = var.monitoring_interval > 0 ? aws_iam_role.rds_monitoring[0].arn : null

  deletion_protection = var.deletion_protection

  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  publicly_accessible = false

  auto_minor_version_upgrade = true

  copy_tags_to_snapshot = true

  skip_final_snapshot = var.skip_final_snapshot

  apply_immediately = var.apply_immediately

  tags = local.common_tags

  depends_on = [
    aws_db_parameter_group.this,
    aws_db_subnet_group.this,
    aws_security_group.rds
  ]
}
