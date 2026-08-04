resource "aws_ecr_repository" "this" {

  name = local.repository_name

  image_tag_mutability = var.image_tag_mutability

  force_delete = false

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {

    encryption_type = "KMS"

    kms_key = var.kms_key_arn

  }

  tags = local.common_tags

}
