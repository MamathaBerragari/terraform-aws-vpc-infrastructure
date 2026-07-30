resource "aws_vpc_endpoint" "this" {
  for_each = var.vpc_endpoints

  vpc_id            = aws_vpc.main.id
  service_name      = each.value.service_name
  vpc_endpoint_type = each.value.vpc_endpoint_type
  policy            = each.value.policy

  private_dns_enabled = (
    each.value.vpc_endpoint_type == "Interface"
    ) ? coalesce(
    each.value.private_dns_enabled,
    true
  ) : null

  subnet_ids = (
    each.value.vpc_endpoint_type == "Interface"
    ) ? (
    length(each.value.subnet_ids) > 0
    ? each.value.subnet_ids
    : [for subnet in aws_subnet.private : subnet.id]
  ) : null

  security_group_ids = (
    each.value.vpc_endpoint_type == "Interface"
  ) ? each.value.security_group_ids : null

  route_table_ids = (
    each.value.vpc_endpoint_type == "Gateway"
    ) ? (
    length(each.value.route_table_ids) > 0
    ? each.value.route_table_ids
    : [for route_table in aws_route_table.private_rt : route_table.id]
  ) : null

  tags = merge(
    local.common_tags,
    each.value.tags,
    {
      Name = "${local.name_prefix}-${each.key}-endpoint"
    }
  )
}
