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
  source           = "../../modules/runtime/eks"
  disk_size        = var.eks_disk_size
  enable_karpenter = true
  # ----------------------------------------------------------
  # Basic EKS Configuration
  # ----------------------------------------------------------

  region       = var.aws_region
  cluster_name = var.cluster_name

  cluster_version    = var.kubernetes_version
  kubernetes_version = var.kubernetes_version

  ip_family = var.eks_ip_family

  authentication_mode = var.eks_authentication_mode

  bootstrap_cluster_creator_admin_permissions = var.eks_bootstrap_cluster_creator_admin_permissions

  # ----------------------------------------------------------
  # EKS Cluster IAM Assume Role Configuration
  # ----------------------------------------------------------

  cluster_assume_role_actions = var.eks_cluster_assume_role_actions

  cluster_assume_role_principal_type = var.eks_cluster_assume_role_principal_type

  cluster_assume_role_principal_identifiers = var.eks_cluster_assume_role_principal_identifiers

  # ----------------------------------------------------------
  # EKS Node IAM Assume Role Configuration
  # ----------------------------------------------------------

  node_assume_role_actions = var.eks_node_assume_role_actions

  node_assume_role_principal_type = var.eks_node_assume_role_principal_type

  node_assume_role_principal_identifiers = var.eks_node_assume_role_principal_identifiers

  # ----------------------------------------------------------
  # EKS IAM Role Names
  # ----------------------------------------------------------

  cluster_role_name_suffix = var.eks_cluster_role_name_suffix

  node_role_name_suffix = var.eks_node_role_name_suffix

  # ----------------------------------------------------------
  # EKS IAM Managed Policies
  # ----------------------------------------------------------

  cluster_policy_arn = var.eks_cluster_policy_arn

  worker_node_policy_arn = var.eks_worker_node_policy_arn

  cni_policy_arn = var.eks_cni_policy_arn

  ecr_read_policy_arn = var.eks_ecr_read_policy_arn

  # ----------------------------------------------------------
  # Networking
  # ----------------------------------------------------------

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  control_plane_subnet_ids = module.vpc.private_subnet_ids

  # ----------------------------------------------------------
  # EKS API Endpoint Configuration
  # ----------------------------------------------------------

  endpoint_private_access = var.eks_endpoint_private_access

  endpoint_public_access = var.eks_endpoint_public_access

  public_access_cidrs = var.eks_public_access_cidrs

  # ----------------------------------------------------------
  # EKS Managed Node Group
  # ----------------------------------------------------------

  node_group_name = var.node_group_name

  node_group_name_suffix = var.eks_node_group_name_suffix

  capacity_type = var.eks_capacity_type

  ami_type = var.eks_ami_type

  instance_types = var.eks_instance_types

  desired_size = var.desired_size

  min_size = var.min_size

  max_size = var.max_size

  max_unavailable = var.eks_max_unavailable

  # ----------------------------------------------------------
  # EKS Launch Template
  # ----------------------------------------------------------

  managed_by = var.eks_managed_by

  module_name = var.eks_module_name

  launch_template_name_suffix = var.eks_launch_template_name_suffix

  launch_template_update_default_version = var.eks_launch_template_update_default_version

  launch_template_http_endpoint = var.eks_launch_template_http_endpoint

  launch_template_http_tokens = var.eks_launch_template_http_tokens

  launch_template_monitoring_enabled = var.eks_launch_template_monitoring_enabled

  launch_template_tag_resource_type = var.eks_launch_template_tag_resource_type

  worker_node_name_suffix = var.eks_worker_node_name_suffix

  # ----------------------------------------------------------
  # CloudWatch CPU Alarm
  # ----------------------------------------------------------

  cpu_alarm_name_suffix = var.eks_cpu_alarm_name_suffix

  cpu_alarm_comparison_operator = var.eks_cpu_alarm_comparison_operator

  cpu_alarm_evaluation_periods = var.eks_cpu_alarm_evaluation_periods

  cpu_alarm_metric_name = var.eks_cpu_alarm_metric_name

  cpu_alarm_namespace = var.eks_cpu_alarm_namespace

  cpu_alarm_period = var.eks_cpu_alarm_period

  cpu_alarm_statistic = var.eks_cpu_alarm_statistic

  cpu_alarm_threshold = var.eks_cpu_alarm_threshold

  cpu_alarm_description = var.eks_cpu_alarm_description

  cpu_alarm_treat_missing_data = var.eks_cpu_alarm_treat_missing_data

  # ----------------------------------------------------------
  # EKS CloudWatch Log Group
  # ----------------------------------------------------------

  eks_log_group_name_prefix = var.eks_log_group_name_prefix

  eks_log_group_name_suffix = var.eks_log_group_name_suffix

  eks_log_retention_in_days = var.eks_log_retention_in_days

  # ----------------------------------------------------------
  # EKS Control Plane Logs
  # ----------------------------------------------------------

  enabled_cluster_log_types = var.enabled_cluster_log_types

  # ----------------------------------------------------------
  # EKS Add-ons
  # ----------------------------------------------------------

  eks_addons = var.eks_addons

  # ----------------------------------------------------------
  # Karpenter
  # ----------------------------------------------------------

  karpenter_chart_version = var.karpenter_chart_version

  # ----------------------------------------------------------
  # Common Tags
  # ----------------------------------------------------------

  tags = local.common_tags


  # ----------------------------------------------------------
  # Karpenter
  # ----------------------------------------------------------

  karpenter_node_class_name = var.karpenter_node_class_name

  karpenter_ami_family = var.karpenter_ami_family

  karpenter_ami_selector_alias = var.karpenter_ami_selector_alias

  karpenter_node_name_prefix = var.karpenter_node_name_prefix

  karpenter_discovery_tag_key = var.karpenter_discovery_tag_key

  karpenter_node_pool_name = var.karpenter_node_pool_name

  karpenter_node_pool_architecture = var.karpenter_node_pool_architecture

  karpenter_node_pool_operating_system = var.karpenter_node_pool_operating_system

  karpenter_node_pool_capacity_types = var.karpenter_node_pool_capacity_types

  karpenter_consolidation_policy = var.karpenter_consolidation_policy

  karpenter_consolidate_after = var.karpenter_consolidate_after

}

############################################################
# Terraform State Address Migration - Karpenter
############################################################

moved {
  from = module.eks.module.karpenter
  to   = module.eks.module.karpenter[0]
}
