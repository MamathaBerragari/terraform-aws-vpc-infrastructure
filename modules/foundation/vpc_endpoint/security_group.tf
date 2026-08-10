resource "aws_security_group" "this" {

  name        = "${var.project_name}-${var.environment}-vpce-sg"
  description = "Security Group for Interface VPC Endpoints"

  vpc_id = var.vpc_id

  ingress {
    description = "HTTPS from approved CIDRs"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = var.endpoint_ingress_cidrs
  }

  egress {
    description = "Endpoint egress"

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = var.endpoint_egress_cidrs
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpce-sg"
    }
  )
}
