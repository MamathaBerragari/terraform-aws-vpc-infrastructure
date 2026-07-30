output "s3_bucket_name" {
  value       = aws_s3_bucket.state_bucket.id
  description = "S3 bucket used for Terraform state"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.lock_table.id
  description = "DynamoDB table name"
}

output "kms_key_arn" {
  value       = aws_kms_key.state_key.arn
  description = "KMS key ARN used for state encryption"
}
