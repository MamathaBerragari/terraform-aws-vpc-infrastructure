output "repository_name" {
  description = "ECR repository name."
  value       = aws_ecr_repository.this.name
}

output "repository_arn" {
  description = "ECR repository ARN."
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "ECR repository URL."
  value       = aws_ecr_repository.this.repository_url
}

output "registry_id" {
  description = "AWS ECR registry ID."
  value       = aws_ecr_repository.this.registry_id
}

output "repository_policy_id" {
  description = "ECR repository policy ID, if a repository policy is configured."
  value       = try(aws_ecr_repository_policy.this[0].id, null)
}

output "enhanced_scanning_configuration_id" {
  description = "Enhanced ECR scanning configuration ID, if enabled."
  value       = try(aws_ecr_registry_scanning_configuration.this[0].id, null)
}
