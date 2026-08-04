resource "aws_iam_role" "enhanced_monitoring" {

  name = "${local.name}-monitoring-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "monitoring.rds.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "monitoring" {

  role = aws_iam_role.enhanced_monitoring.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
