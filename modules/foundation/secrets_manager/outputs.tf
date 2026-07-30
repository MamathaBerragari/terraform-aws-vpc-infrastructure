output "secret_id" {
  description = "Secrets Manager secret ID."
  value       = aws_secretsmanager_secret.this.id
}

output "secret_arn" {
  description = "Secrets Manager secret ARN."
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "Secrets Manager secret name."
  value       = aws_secretsmanager_secret.this.name
}

output "rotation_enabled" {
  description = "Whether automatic rotation is configured."
  value       = var.create_rotation
}
