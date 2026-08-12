#############################################################
# Interface VPC Endpoints
#############################################################

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(var.interface_endpoints)

  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.aws_region}.${each.value}"

  vpc_endpoint_type = "Interface"

  subnet_ids = var.private_subnet_ids

  security_group_ids = [
    aws_security_group.this.id
  ]

  private_dns_enabled = var.private_dns_enabled

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-${each.value}"
    }
  )
}

#############################################################
# Gateway VPC Endpoints
#############################################################

resource "aws_vpc_endpoint" "gateway" {
  for_each = toset(var.gateway_endpoints)

  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.aws_region}.${each.value}"

  vpc_endpoint_type = "Gateway"

  route_table_ids = var.private_route_table_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-${each.value}"
    }
  )
}
