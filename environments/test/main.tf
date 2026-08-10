module "vpc" {
  source = "../../modules/foundation/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_dns_support      = var.enable_dns_support
  instance_tenancy        = var.instance_tenancy
  single_nat_gateway      = var.single_nat_gateway
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags                = var.tags
  public_subnet_tags  = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags
}

module "vpc_endpoint" {
  source = "../../modules/foundation/vpc_endpoint"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  private_route_table_ids = module.vpc.private_route_table_ids

  interface_endpoints = var.interface_endpoints

  gateway_endpoints = var.gateway_endpoints

  private_dns_enabled = var.private_dns_enabled

  endpoint_ingress_cidrs = [
    var.vpc_cidr
  ]

  endpoint_egress_cidrs = var.endpoint_egress_cidrs

  tags = var.tags
}

module "ecr" {
  source = "../../modules/runtime/ecr"

  repository_name           = var.ecr_repository_name
  image_tag_mutability      = var.ecr_image_tag_mutability
  scan_on_push              = var.ecr_scan_on_push
  lifecycle_max_image_count = var.ecr_lifecycle_max_image_count

  repository_read_principals  = var.ecr_repository_read_principals
  repository_write_principals = var.ecr_repository_write_principals

  tags = var.tags
}


module "eks" {

  source = "../../modules/runtime/eks"

  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  control_plane_subnet_ids = module.vpc.private_subnet_ids

  tags = var.tags

  region = var.aws_region

}

# ==============================================================
# Terraform State Address Migration
# Preserve existing VPC resources while changing for_each keys
# from numeric keys to Availability Zone keys.
# ==============================================================

moved {
  from = module.vpc.aws_subnet.public["01"]
  to   = module.vpc.aws_subnet.public["ap-south-1a"]
}

moved {
  from = module.vpc.aws_subnet.public["02"]
  to   = module.vpc.aws_subnet.public["ap-south-1b"]
}

moved {
  from = module.vpc.aws_subnet.private["01"]
  to   = module.vpc.aws_subnet.private["ap-south-1a"]
}

moved {
  from = module.vpc.aws_subnet.private["02"]
  to   = module.vpc.aws_subnet.private["ap-south-1b"]
}

moved {
  from = module.vpc.aws_route_table.private_rt["01"]
  to   = module.vpc.aws_route_table.private_rt["ap-south-1a"]
}

moved {
  from = module.vpc.aws_route_table.private_rt["02"]
  to   = module.vpc.aws_route_table.private_rt["ap-south-1b"]
}

moved {
  from = module.vpc.aws_route_table_association.private_assoc["01"]
  to   = module.vpc.aws_route_table_association.private_assoc["ap-south-1a"]
}

moved {
  from = module.vpc.aws_route_table_association.private_assoc["02"]
  to   = module.vpc.aws_route_table_association.private_assoc["ap-south-1b"]
}

moved {
  from = module.vpc.aws_route_table_association.public_assoc["01"]
  to   = module.vpc.aws_route_table_association.public_assoc["ap-south-1a"]
}

moved {
  from = module.vpc.aws_route_table_association.public_assoc["02"]
  to   = module.vpc.aws_route_table_association.public_assoc["ap-south-1b"]
}
