output "db_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "RDS instance ARN"
  value       = aws_db_instance.this.arn
}

output "db_resource_id" {
  description = "RDS resource ID used for IAM database authentication"
  value       = aws_db_instance.this.resource_id
}

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "RDS database hostname"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "RDS database port"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "RDS database name"
  value       = aws_db_instance.this.db_name
}

output "security_group_id" {
  description = "RDS security group ID"
  value       = aws_security_group.rds.id
}

output "subnet_group" {
  description = "RDS subnet group"
  value       = aws_db_subnet_group.this.name
}

output "master_user_secret_arn" {
  description = "AWS Secrets Manager ARN managed by RDS"
  value       = try(aws_db_instance.this.master_user_secret[0].secret_arn, null)
}

output "master_user_secret_status" {
  description = "RDS managed master user secret status"
  value       = try(aws_db_instance.this.master_user_secret[0].secret_status, null)
}
