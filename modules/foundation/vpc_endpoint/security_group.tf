resource "aws_security_group" "this" {
  name        = "${var.project_name}-${var.environment}-vpce-sg"
  description = var.security_group_description
  vpc_id      = var.vpc_id

  ingress {
    description = var.endpoint_ingress_description

    from_port = var.endpoint_port
    to_port   = var.endpoint_port
    protocol  = var.endpoint_protocol

    cidr_blocks = var.endpoint_ingress_cidrs
  }

  egress {
    description = var.endpoint_egress_description

    from_port = var.endpoint_egress_from_port
    to_port   = var.endpoint_egress_to_port
    protocol  = var.endpoint_egress_protocol

    cidr_blocks = var.endpoint_egress_cidrs
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpce-sg"
    }
  )

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}
