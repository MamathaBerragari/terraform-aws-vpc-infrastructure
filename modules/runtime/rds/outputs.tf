output "db_instance_id" {

  description = "RDS Instance ID"

  value = aws_db_instance.this.id
}

output "db_instance_arn" {

  description = "RDS ARN"

  value = aws_db_instance.this.arn
}

output "db_endpoint" {

  description = "Database Endpoint"

  value = aws_db_instance.this.endpoint
}

output "db_address" {

  description = "Database Address"

  value = aws_db_instance.this.address
}

output "db_port" {

  description = "Database Port"

  value = aws_db_instance.this.port
}

output "db_name" {

  description = "Database Name"

  value = aws_db_instance.this.db_name
}

output "security_group_id" {

  description = "RDS Security Group"

  value = aws_security_group.rds.id
}

output "subnet_group" {

  description = "DB Subnet Group"

  value = aws_db_subnet_group.this.name
}
