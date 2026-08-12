resource "aws_iam_role" "rds_connect" {
  count = var.create_rds_connect_role ? 1 : 0

  name = "${local.name}-db-connect-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy" "rds_connect" {
  count = var.create_rds_connect_role ? 1 : 0

  name = "${local.name}-db-connect-policy"

  role = aws_iam_role.rds_connect[0].id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "rds-db:connect"
        ]

        Resource = [
          "arn:${data.aws_partition.current.partition}:rds-db:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_db_instance.this.resource_id}/${var.master_username}"
        ]
      }
    ]
  })
}
