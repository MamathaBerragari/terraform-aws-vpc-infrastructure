resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  instance_tenancy = var.instance_tenancy

  enable_dns_hostnames = var.enable_dns_hostnames

  enable_dns_support = var.enable_dns_support

  tags = merge(
    local.common_tags,
    {
      Name = local.name_prefix
    }
  )
}
