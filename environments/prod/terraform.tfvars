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

eks_ip_family = "ipv4"

eks_authentication_mode = "API_AND_CONFIG_MAP"

eks_bootstrap_cluster_creator_admin_permissions = true


node_group_name = "default"

desired_size = 3
min_size     = 2
max_size     = 5

############################################################
# EKS IAM Configuration
############################################################

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

############################################################
# EKS IAM Role Names
############################################################

eks_cluster_role_name_suffix = "cluster-role"

eks_node_role_name_suffix = "node-role"

############################################################
# EKS Managed IAM Policies
############################################################

eks_cluster_policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

eks_worker_node_policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

eks_cni_policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

eks_ecr_read_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"


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
# EKS Common Tags
############################################################

eks_managed_by  = "Terraform"
eks_module_name = "Runtime-EKS"

############################################################
# EKS Launch Template
############################################################

eks_launch_template_name_suffix            = "-lt-"
eks_launch_template_update_default_version = true
eks_launch_template_http_endpoint          = "enabled"
eks_launch_template_http_tokens            = "required"
eks_launch_template_monitoring_enabled     = true
eks_launch_template_tag_resource_type      = "instance"
eks_worker_node_name_suffix                = "-worker"

############################################################
# EKS CloudWatch CPU Alarm
############################################################

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


############################################################
# EKS Node Group Configuration
############################################################
eks_disk_size              = 50
eks_node_group_name_suffix = "-default"

eks_capacity_type = "ON_DEMAND"

eks_ami_type = "AL2023_x86_64_STANDARD"

eks_instance_types = [
  "t3.medium"
]

eks_max_unavailable = 1


enabled_cluster_log_types = [
  "api",
  "audit",
  "authenticator",
  "controllerManager",
  "scheduler"
]

############################################################
# EKS API Endpoint Configuration
############################################################
eks_endpoint_private_access = true
eks_endpoint_public_access  = true
eks_public_access_cidrs     = ["0.0.0.0/0"]


############################################################
# EKS CloudWatch Log Group
############################################################

eks_log_group_name_prefix = "/aws/eks/"
eks_log_group_name_suffix = "/cluster"
eks_log_retention_in_days = 30


############################################################
# KARPENTER
############################################################

karpenter_chart_version = "1.3.3"

karpenter_node_class_name = "default"

karpenter_ami_family = "AL2023"

karpenter_ami_selector_alias = "al2023@latest"

karpenter_node_name_prefix = "karpenter-node"

karpenter_discovery_tag_key = "karpenter.sh/discovery"

karpenter_node_pool_name = "default"

karpenter_node_pool_architecture = "amd64"

karpenter_node_pool_operating_system = "linux"

karpenter_node_pool_capacity_types = [
  "on-demand",
  "spot"
]

karpenter_consolidation_policy = "WhenEmpty"

karpenter_consolidate_after = "30s"

############################################################
# Karpenter
############################################################

enable_karpenter = true


rds_db_identifier = "postgres"

rds_engine                 = "postgres"
rds_engine_version         = "16"
rds_parameter_group_family = "postgres16"

rds_instance_class = "db.t3.micro"

rds_allocated_storage     = 20
rds_max_allocated_storage = 50
rds_storage_type          = "gp3"

rds_database_name = "applicationdb"
rds_port          = 5432

rds_master_username = "postgresadmin"

rds_multi_az = false

rds_storage_encrypted = true
rds_kms_key_id        = null

rds_backup_retention_period = 7

rds_performance_insights_enabled = false
rds_monitoring_interval          = 0

rds_deletion_protection = false

rds_skip_final_snapshot = true
rds_apply_immediately   = true

rds_iam_database_authentication_enabled = true

rds_create_connect_role = false

rds_secret_recovery_window_in_days = 0


rds_log_connections    = "1"
rds_log_disconnections = "1"
rds_log_statement      = "ddl"


endpoint_ingress_description = "Allow HTTPS from VPC"
endpoint_port                = 443
endpoint_protocol            = "tcp"

endpoint_egress_description = "Allow outbound HTTPS"
endpoint_egress_from_port   = 0
endpoint_egress_to_port     = 0
endpoint_egress_protocol    = "-1"

security_group_description = "Security Group for Interface VPC Endpoints"

rds_backup_window      = "18:00-19:00"
rds_maintenance_window = "sun:19:00-sun:20:00"

ecr_kms_encryption_enabled = false
