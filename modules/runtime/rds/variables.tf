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
  default     = "postgres"
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "16"
}

variable "parameter_group_family" {
  description = "RDS parameter group family"
  type        = string
  default     = "postgres16"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Initial storage in GB"
  type        = number
}

variable "max_allocated_storage" {
  description = "Maximum autoscaling storage in GB"
  type        = number
}

variable "storage_type" {
  description = "RDS storage type"
  type        = string
  default     = "gp3"
}

variable "database_name" {
  description = "Initial database name"
  type        = string
}

variable "port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "multi_az" {
  description = "Enable Multi-AZ"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ARN or ID"
  type        = string
  default     = null
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_security_groups" {
  description = "Security groups allowed to connect to RDS"
  type        = list(string)
  default     = []
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "18:00-19:00"
}

variable "maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "sun:19:00-sun:20:00"
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds. 0 disables it."
  type        = number
  default     = 0
}

variable "deletion_protection" {
  description = "Protect RDS from deletion"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying RDS"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
  default     = true
}

variable "iam_database_authentication_enabled" {
  description = "Enable IAM database authentication"
  type        = bool
  default     = true
}

variable "create_rds_connect_role" {
  description = "Create EC2 IAM role for IAM database authentication"
  type        = bool
  default     = false
}


variable "secret_recovery_window_in_days" {
  description = "Secrets Manager recovery window"
  type        = number
  default     = 0
}

variable "master_username" {
  description = "RDS master username"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to RDS resources"
  type        = map(string)
  default     = {}
}
