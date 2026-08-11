############################################################
# COMMON / PROJECT
############################################################

project_name = "terraform-project"
environment  = "prod"

aws_region = "ap-south-1"


############################################################
# VPC
############################################################

vpc_cidr = "10.20.0.0/16"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

public_subnet_cidrs = [
  "10.20.1.0/24",
  "10.20.2.0/24"
]

private_subnet_cidrs = [
  "10.20.11.0/24",
  "10.20.12.0/24"
]

enable_dns_hostnames    = true
enable_dns_support      = true
instance_tenancy        = "default"
map_public_ip_on_launch = true

interface_endpoints = [
  "ec2",
  "ecr.api",
  "ecr.dkr",
  "sts",
  "logs"
]

gateway_endpoints = [
  "s3"
]

private_dns_enabled = true

endpoint_ingress_cidrs = [
  "10.20.0.0/16"
]

endpoint_egress_cidrs = [
  "0.0.0.0/0"
]

public_subnet_tags = {
  "kubernetes.io/role/elb" = "1"
}

private_subnet_tags = {
  "karpenter.sh/discovery"          = "prod-eks"
  "kubernetes.io/role/internal-elb" = "1"
}


############################################################
# ECR
############################################################

ecr_repository_name      = "my-application"
ecr_image_tag_mutability = "IMMUTABLE"
ecr_scan_on_push         = true

ecr_force_delete = false

ecr_enhanced_scanning_enabled = true
ecr_enhanced_scanning_type    = "CONTINUOUS_SCAN"

ecr_encryption_type = "AES256"
ecr_kms_key_arn     = null

ecr_repository_read_principals  = []
ecr_repository_write_principals = []

# ECR Lifecycle Policy

ecr_lifecycle_rule_priority = 1

ecr_lifecycle_description = "Expire old images"

ecr_lifecycle_tag_status = "any"

ecr_lifecycle_count_type = "imageCountMoreThan"

ecr_lifecycle_max_image_count = 20

ecr_lifecycle_action_type = "expire"

ecr_managed_by  = "Terraform"
ecr_module_name = "runtime-ecr"

ecr_enhanced_scanning_scan_type   = "ENHANCED"
ecr_enhanced_scanning_filter_type = "WILDCARD"

############################################################
# EKS
############################################################

cluster_name = "prod-eks"

kubernetes_version = "1.31"

node_group_name = "default"

desired_size = 3
min_size     = 2
max_size     = 5


############################################################
# EKS ADD-ONS
############################################################

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


############################################################
# KARPENTER
############################################################

karpenter_chart_version = "1.3.3"
