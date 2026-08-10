resource "aws_eip" "nat" {
  for_each = local.nat_gateway_subnets

  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-nat-eip-${each.key}"
    }
  )
}

resource "aws_nat_gateway" "nat" {
  for_each = local.nat_gateway_subnets

  allocation_id = aws_eip.nat[each.key].id

  subnet_id = aws_subnet.public[each.value.public_subnet_key].id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-nat-${each.key}"
    }
  )
}
