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

  tags                = local.common_tags
  public_subnet_tags  = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags
}

module "vpc_endpoint" {
  source = "../../modules/foundation/vpc_endpoint"

  project_name = var.project_name
  aws_region   = var.aws_region
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  private_subnet_ids      = module.vpc.private_subnet_ids
  private_route_table_ids = module.vpc.private_route_table_ids

  interface_endpoints = var.interface_endpoints
  gateway_endpoints   = var.gateway_endpoints

  private_dns_enabled    = var.private_dns_enabled
  endpoint_ingress_cidrs = var.endpoint_ingress_cidrs
  endpoint_egress_cidrs  = var.endpoint_egress_cidrs

  tags = local.common_tags
}

module "ecr" {
  source = "../../modules/runtime/ecr"

  repository_name = var.ecr_repository_name

  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push

  enhanced_scanning_enabled = var.ecr_enhanced_scanning_enabled
  enhanced_scanning_type    = var.ecr_enhanced_scanning_type

  encryption_type = var.ecr_encryption_type
  kms_key_arn     = var.ecr_kms_key_arn

  repository_read_principals  = var.ecr_repository_read_principals
  repository_write_principals = var.ecr_repository_write_principals

  lifecycle_rule_priority   = var.ecr_lifecycle_rule_priority
  lifecycle_description     = var.ecr_lifecycle_description
  lifecycle_tag_status      = var.ecr_lifecycle_tag_status
  lifecycle_count_type      = var.ecr_lifecycle_count_type
  lifecycle_max_image_count = var.ecr_lifecycle_max_image_count
  lifecycle_action_type     = var.ecr_lifecycle_action_type

  managed_by  = var.ecr_managed_by
  module_name = var.ecr_module_name

  force_delete = var.ecr_force_delete

  enhanced_scanning_scan_type   = var.ecr_enhanced_scanning_scan_type
  enhanced_scanning_filter_type = var.ecr_enhanced_scanning_filter_type

  tags = local.common_tags
}

module "eks" {
  source = "../../modules/runtime/eks"

  region       = var.aws_region
  cluster_name = var.cluster_name

  ip_family = var.eks_ip_family

  authentication_mode = var.eks_authentication_mode

  bootstrap_cluster_creator_admin_permissions = var.eks_bootstrap_cluster_creator_admin_permissions

  cluster_assume_role_actions               = var.eks_cluster_assume_role_actions
  cluster_assume_role_principal_type        = var.eks_cluster_assume_role_principal_type
  cluster_assume_role_principal_identifiers = var.eks_cluster_assume_role_principal_identifiers

  node_assume_role_actions               = var.eks_node_assume_role_actions
  node_assume_role_principal_type        = var.eks_node_assume_role_principal_type
  node_assume_role_principal_identifiers = var.eks_node_assume_role_principal_identifiers

  cluster_role_name_suffix = var.eks_cluster_role_name_suffix
  node_role_name_suffix    = var.eks_node_role_name_suffix

  cluster_policy_arn     = var.eks_cluster_policy_arn
  worker_node_policy_arn = var.eks_worker_node_policy_arn
  cni_policy_arn         = var.eks_cni_policy_arn
  ecr_read_policy_arn    = var.eks_ecr_read_policy_arn


  kubernetes_version = var.kubernetes_version
  cluster_version    = var.kubernetes_version

  karpenter_chart_version = var.karpenter_chart_version

  node_group_name = var.node_group_name

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  vpc_id = module.vpc.vpc_id

  private_subnet_ids       = module.vpc.private_subnet_ids
  control_plane_subnet_ids = module.vpc.private_subnet_ids

  eks_addons = var.eks_addons

  tags = local.common_tags
}
