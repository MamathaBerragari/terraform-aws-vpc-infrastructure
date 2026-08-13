variable "environment" {
  description = "Environment name"
  type        = string
}

variable "db_identifier" {
  description = "RDS identifier suffix"
  type        = string
}

variable "engine" {
  description = "RDS database engine"
  type        = string
}

variable "engine_version" {
  description = "RDS database engine version"
  type        = string
}

variable "parameter_group_family" {
  description = "RDS parameter group family"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Initial RDS storage in GB"
  type        = number
}

variable "max_allocated_storage" {
  description = "Maximum RDS autoscaling storage in GB"
  type        = number
}

variable "storage_type" {
  description = "RDS storage type"
  type        = string
}

variable "database_name" {
  description = "Initial database name"
  type        = string
}

variable "port" {
  description = "RDS database port"
  type        = number
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
}

variable "storage_encrypted" {
  description = "Enable RDS storage encryption"
  type        = bool
}

variable "kms_key_id" {
  description = "KMS key ARN or ID"
  type        = string
  nullable    = true
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by RDS"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where RDS security group is created"
  type        = string
}

variable "allowed_security_groups" {
  description = "Security groups allowed to connect to RDS"
  type        = list(string)
}

variable "backup_retention_period" {
  description = "Automated backup retention period in days"
  type        = number
}

variable "backup_window" {
  description = "Preferred automated backup window"
  type        = string
}

variable "maintenance_window" {
  description = "Preferred RDS maintenance window"
  type        = string
}

variable "performance_insights_enabled" {
  description = "Enable RDS Performance Insights"
  type        = bool
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds"
  type        = number
}

variable "deletion_protection" {
  description = "Enable RDS deletion protection"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when RDS is destroyed"
  type        = bool
}

variable "apply_immediately" {
  description = "Apply RDS modifications immediately"
  type        = bool
}

variable "iam_database_authentication_enabled" {
  description = "Enable IAM database authentication"
  type        = bool
}

variable "create_rds_connect_role" {
  description = "Create IAM role allowing EC2 to connect to RDS using IAM authentication"
  type        = bool
}

variable "secret_recovery_window_in_days" {
  description = "Secrets Manager recovery window in days"
  type        = number
}

variable "master_username" {
  description = "RDS master username"
  type        = string
}

variable "rds_log_connections" {
  description = "PostgreSQL log_connections parameter value"
  type        = string
}

variable "rds_log_disconnections" {
  description = "PostgreSQL log_disconnections parameter value"
  type        = string
}

variable "rds_log_statement" {
  description = "PostgreSQL log_statement parameter value"
  type        = string
}

variable "tags" {
  description = "Additional tags applied to RDS resources"
  type        = map(string)
}
