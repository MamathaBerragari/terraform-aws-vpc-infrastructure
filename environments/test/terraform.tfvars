aws_region = "ap-south-1"

project_name = "terraform-project"

karpenter_chart_version = "1.3.3"

environment = "test"

vpc_cidr = "10.10.0.0/16"


availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]


public_subnet_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24"
]


private_subnet_cidrs = [
  "10.10.11.0/24",
  "10.10.12.0/24"
]

enable_dns_hostnames = true

enable_dns_support = true

instance_tenancy = "default"

single_nat_gateway = false

map_public_ip_on_launch = true

tags = {
  Project     = "terraform-project"
  Environment = "test"
}

public_subnet_tags = {}

private_subnet_tags = {}

cluster_name = "test-eks"

kubernetes_version = "1.31"

node_group_name = "default"

desired_size = 2

min_size = 1

max_size = 3

interface_endpoints = [
  "ec2",
  "ecr.api",
  "ecr.dkr",
  "logs",
  "sts"
]

gateway_endpoints = [
  "s3"
]

private_dns_enabled = true

endpoint_egress_cidrs = [
  "0.0.0.0/0"
]

ecr_repository_name = "my-application-test"

ecr_image_tag_mutability      = "IMMUTABLE"
ecr_scan_on_push              = true
ecr_lifecycle_max_image_count = 20

ecr_repository_read_principals  = []
ecr_repository_write_principals = []

ecr_force_delete = false

ecr_enhanced_scanning_enabled = true
ecr_enhanced_scanning_type    = "CONTINUOUS_SCAN"

ecr_encryption_type = "AES256"
ecr_kms_key_arn     = null

ecr_lifecycle_rule_priority = 1
ecr_lifecycle_description   = "Expire old images"
ecr_lifecycle_tag_status    = "any"
ecr_lifecycle_count_type    = "imageCountMoreThan"
ecr_lifecycle_action_type   = "expire"

ecr_managed_by  = "Terraform"
ecr_module_name = "runtime-ecr"

ecr_enhanced_scanning_scan_type   = "ENHANCED"
ecr_enhanced_scanning_filter_type = "WILDCARD"

enable_karpenter = false


endpoint_ingress_cidrs = [
  "10.10.0.0/16"
]

endpoint_ingress_description = "Allow HTTPS from VPC"

endpoint_port = 443

endpoint_protocol = "tcp"

endpoint_egress_description = "Allow outbound HTTPS"

endpoint_egress_from_port = 0

endpoint_egress_to_port = 0

endpoint_egress_protocol = "-1"

security_group_description = "Security Group for Interface VPC Endpoints"



# ============================================================
# EKS BASIC CONFIGURATION
# ============================================================

eks_ip_family = "ipv4"

eks_authentication_mode = "API_AND_CONFIG_MAP"

eks_bootstrap_cluster_creator_admin_permissions = true


# ============================================================
# EKS IAM
# ============================================================

eks_cluster_assume_role_actions = [
  "sts:AssumeRole"
]

eks_cluster_assume_role_principal_type = "Service"

eks_cluster_assume_role_principal_identifiers = [
  "eks.amazonaws.com"
]

eks_node_assume_role_actions = [
  "sts:AssumeRole"
]

eks_node_assume_role_principal_type = "Service"

eks_node_assume_role_principal_identifiers = [
  "ec2.amazonaws.com"
]


# ============================================================
# EKS IAM ROLE NAMES
# ============================================================

eks_cluster_role_name_suffix = "cluster-role"

eks_node_role_name_suffix = "node-role"


# ============================================================
# EKS IAM POLICIES
# ============================================================

eks_cluster_policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

eks_worker_node_policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

eks_cni_policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

eks_ecr_read_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"


# ============================================================
# EKS ADD-ONS
# ============================================================

eks_addons = {
  vpc_cni = {
    addon_name                  = "vpc-cni"
    addon_version               = null
    resolve_conflicts_on_create = "OVERWRITE"
    service_account_role_type   = "none"
  }

  coredns = {
    addon_name                  = "coredns"
    addon_version               = null
    resolve_conflicts_on_create = "OVERWRITE"
    service_account_role_type   = "none"
  }

  kube_proxy = {
    addon_name                  = "kube-proxy"
    addon_version               = null
    resolve_conflicts_on_create = "OVERWRITE"
    service_account_role_type   = "none"
  }

  ebs_csi = {
    addon_name                  = "aws-ebs-csi-driver"
    addon_version               = null
    resolve_conflicts_on_create = "OVERWRITE"
    service_account_role_type   = "ebs_csi"
  }
}


# ============================================================
# EKS COMMON
# ============================================================

eks_managed_by  = "Terraform"
eks_module_name = "Runtime-EKS"


# ============================================================
# LAUNCH TEMPLATE
# ============================================================

eks_launch_template_name_suffix            = "-lt-"
eks_launch_template_update_default_version = true
eks_launch_template_http_endpoint          = "enabled"
eks_launch_template_http_tokens            = "required"
eks_launch_template_monitoring_enabled     = true
eks_launch_template_tag_resource_type      = "instance"
eks_worker_node_name_suffix                = "-worker"


# ============================================================
# CPU ALARM
# ============================================================

eks_cpu_alarm_name_suffix         = "-high-cpu"
eks_cpu_alarm_comparison_operator = "GreaterThanThreshold"
eks_cpu_alarm_evaluation_periods  = 2
eks_cpu_alarm_metric_name         = "CPUUtilization"
eks_cpu_alarm_namespace           = "AWS/EKS"
eks_cpu_alarm_period              = 300
eks_cpu_alarm_statistic           = "Average"
eks_cpu_alarm_threshold           = 80
eks_cpu_alarm_description         = "High CPU utilization on EKS cluster"
eks_cpu_alarm_treat_missing_data  = "notBreaching"


# ============================================================
# NODE GROUP
# ============================================================

eks_disk_size              = 50
eks_node_group_name_suffix = "-default"

eks_capacity_type = "ON_DEMAND"

eks_ami_type = "AL2023_x86_64_STANDARD"

eks_instance_types = [
  "t3.medium"
]

eks_max_unavailable = 1

# ============================================================
# EKS API ENDPOINT
# ============================================================

eks_endpoint_private_access = true

eks_endpoint_public_access = true

eks_public_access_cidrs = [
  "0.0.0.0/0"
]


# ============================================================
# EKS LOGGING
# ============================================================

enabled_cluster_log_types = [
  "api",
  "audit",
  "authenticator",
  "controllerManager",
  "scheduler"
]

eks_log_group_name_prefix = "/aws/eks/"

eks_log_group_name_suffix = "/cluster"

eks_log_retention_in_days = 30


# ============================================================
# KARPENTER
# ============================================================

karpenter_ami_family         = "AL2023"
karpenter_ami_selector_alias = "al2023@latest"
karpenter_node_class_name    = "test-eks-node-class"

karpenter_node_name_prefix  = "test-eks-karpenter"
karpenter_discovery_tag_key = "karpenter.sh/discovery"

karpenter_node_pool_name             = "test-eks-node-pool"
karpenter_node_pool_architecture     = "amd64"
karpenter_node_pool_operating_system = "linux"
karpenter_node_pool_capacity_types   = ["on-demand", "spot"]

karpenter_consolidation_policy = "WhenEmptyOrUnderutilized"
karpenter_consolidate_after    = "1m"
rds_master_username            = "postgresadmin"
