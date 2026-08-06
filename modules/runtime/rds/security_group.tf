resource "aws_security_group" "rds" {

  name = "${local.name}-sg"

  description = "Security Group for Amazon RDS"

  vpc_id = var.vpc_id

  ingress {

    from_port = var.port

    to_port = var.port

    protocol = "tcp"

    security_groups = var.allowed_security_groups

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = local.common_tags
}
