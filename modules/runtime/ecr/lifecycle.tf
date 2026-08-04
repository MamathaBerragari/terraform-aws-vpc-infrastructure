resource "aws_ecr_lifecycle_policy" "this" {

  repository = aws_ecr_repository.this.name

  policy = jsonencode({

    rules = [

      {

        rulePriority = 1

        description = "Expire old images"

        selection = {

          tagStatus = "any"

          countType = "imageCountMoreThan"

          countNumber = var.lifecycle_max_image_count

        }

        action = {

          type = "expire"

        }

      }

    ]

  })

}
