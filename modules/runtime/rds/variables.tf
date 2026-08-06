variable "environment" {
  type = string
}

variable "db_identifier" {
  type = string
}

variable "database_name" {
  type = string
}

variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "port" {
  type    = number
  default = 5432
}

variable "multi_az" {
  type    = bool
  default = true
}

variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "kms_key_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "allowed_security_groups" {
  type = list(string)
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "performance_insights_enabled" {
  type    = bool
  default = true
}

variable "monitoring_interval" {
  type    = number
  default = 60
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
