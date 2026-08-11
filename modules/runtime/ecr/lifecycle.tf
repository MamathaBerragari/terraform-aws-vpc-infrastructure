############################################################
# ECR Lifecycle Policy
############################################################

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = var.lifecycle_rule_priority

        description = var.lifecycle_description

        selection = {
          tagStatus   = var.lifecycle_tag_status
          countType   = var.lifecycle_count_type
          countNumber = var.lifecycle_max_image_count
        }

        action = {
          type = var.lifecycle_action_type
        }
      }
    ]
  })
}
