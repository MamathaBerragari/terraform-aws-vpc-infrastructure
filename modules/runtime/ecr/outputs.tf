output "repository_name" {

  description = "ECR Repository Name"

  value = aws_ecr_repository.this.name

}

output "repository_arn" {

  description = "ECR Repository ARN"

  value = aws_ecr_repository.this.arn

}

output "repository_url" {

  description = "Repository URL"

  value = aws_ecr_repository.this.repository_url

}

output "registry_id" {

  description = "AWS Registry ID"

  value = aws_ecr_repository.this.registry_id

}

output "iam_policy_arn" {

  description = "IAM Policy ARN"

  value = aws_iam_policy.ecr.arn

}
