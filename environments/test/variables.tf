variable "aws_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "availability_zones" {
  type = list(string)
}


variable "cluster_name" {
  type = string
}


variable "node_group_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_dns_support" {
  type = bool
}

variable "instance_tenancy" {
  type = string
}

variable "single_nat_gateway" {
  type = bool
}

variable "map_public_ip_on_launch" {
  type = bool
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "interface_endpoints" {
  description = "AWS Interface VPC Endpoint services"
  type        = list(string)
}

variable "gateway_endpoints" {
  description = "AWS Gateway VPC Endpoint services"
  type        = list(string)
}

variable "private_dns_enabled" {
  description = "Enable private DNS for Interface VPC Endpoints"
  type        = bool
}

variable "endpoint_egress_cidrs" {
  description = "CIDRs allowed for Interface VPC Endpoint egress"
  type        = list(string)
}

variable "ecr_repository_name" {
  description = "ECR repository name for the environment."
  type        = string
}

variable "ecr_image_tag_mutability" {
  description = "ECR image tag mutability."
  type        = string
  default     = "IMMUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Enable ECR image scanning on push."
  type        = bool
  default     = true
}

variable "ecr_lifecycle_max_image_count" {
  description = "Maximum ECR images to retain."
  type        = number
  default     = 20
}

variable "ecr_repository_read_principals" {
  description = "IAM principals allowed to pull from ECR."
  type        = list(string)
  default     = []
}

variable "ecr_repository_write_principals" {
  description = "IAM principals allowed to push to ECR."
  type        = list(string)
  default     = []
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."

  type = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+$", var.kubernetes_version))
    error_message = "kubernetes_version must be in the format major.minor, for example 1.31."
  }
}

variable "karpenter_chart_version" {
  description = "Karpenter Helm chart version"
  type        = string
}

variable "ecr_force_delete" {
  type = bool
}

variable "ecr_enhanced_scanning_enabled" {
  type = bool
}

variable "ecr_enhanced_scanning_type" {
  type = string
}

variable "ecr_enhanced_scanning_scan_type" {
  type = string
}

variable "ecr_enhanced_scanning_filter_type" {
  type = string
}

variable "ecr_encryption_type" {
  type = string
}

variable "ecr_kms_key_arn" {
  type    = string
  default = null
}

variable "ecr_lifecycle_rule_priority" {
  type = number
}

variable "ecr_lifecycle_description" {
  type = string
}

variable "ecr_lifecycle_tag_status" {
  type = string
}

variable "ecr_lifecycle_count_type" {
  type = string
}

variable "ecr_lifecycle_action_type" {
  type = string
}

variable "ecr_managed_by" {
  type = string
}

variable "ecr_module_name" {
  type = string
}

variable "enable_karpenter" {
  description = "Whether to deploy Karpenter."
  type        = bool
  default     = false
}

variable "eks_ip_family" {
  description = "IP address family used by the EKS cluster."
  type        = string

  validation {
    condition = contains(
      ["ipv4", "ipv6"],
      var.eks_ip_family
    )

    error_message = "eks_ip_family must be either ipv4 or ipv6."
  }
}

variable "eks_authentication_mode" {
  description = "Authentication mode used by the EKS cluster."
  type        = string

  validation {
    condition = contains(
      ["CONFIG_MAP", "API", "API_AND_CONFIG_MAP"],
      var.eks_authentication_mode
    )

    error_message = "eks_authentication_mode must be CONFIG_MAP, API, or API_AND_CONFIG_MAP."
  }
}

variable "eks_bootstrap_cluster_creator_admin_permissions" {
  description = "Whether the cluster creator receives bootstrap administrator permissions."
  type        = bool
}

variable "eks_addons" {
  description = "EKS managed add-ons configured for this environment."

  type = map(object({
    addon_name                    = string
    addon_version                 = optional(string)
    resolve_conflicts_on_create   = string
    requires_service_account_role = optional(bool, false)
  }))
}

variable "eks_cluster_assume_role_actions" {
  description = "IAM actions allowed for the EKS cluster assume role."
  type        = list(string)
}

variable "eks_cluster_assume_role_principal_type" {
  description = "Principal type for the EKS cluster IAM role."
  type        = string
}

variable "eks_cluster_assume_role_principal_identifiers" {
  description = "Principal identifiers for the EKS cluster IAM role."
  type        = list(string)
}

variable "eks_node_assume_role_actions" {
  description = "IAM actions allowed for the EKS node assume role."
  type        = list(string)
}

variable "eks_node_assume_role_principal_type" {
  description = "Principal type for the EKS node IAM role."
  type        = string
}

variable "eks_node_assume_role_principal_identifiers" {
  description = "Principal identifiers for the EKS node IAM role."
  type        = list(string)
}

variable "eks_cluster_role_name_suffix" {
  description = "Suffix used for the EKS cluster IAM role name."
  type        = string
}

variable "eks_node_role_name_suffix" {
  description = "Suffix used for the EKS node IAM role name."
  type        = string
}

variable "eks_cluster_policy_arn" {
  description = "IAM policy ARN attached to the EKS cluster role."
  type        = string
}

variable "eks_worker_node_policy_arn" {
  description = "IAM policy ARN attached to EKS worker nodes."
  type        = string
}

variable "eks_cni_policy_arn" {
  description = "IAM policy ARN attached to EKS worker nodes for VPC CNI."
  type        = string
}

variable "eks_ecr_read_policy_arn" {
  description = "IAM policy ARN attached to EKS worker nodes for ECR read access."
  type        = string
}

variable "eks_managed_by" {
  description = "ManagedBy tag value for EKS resources."
  type        = string
}

variable "eks_module_name" {
  description = "Module tag value for EKS resources."
  type        = string
}

variable "eks_launch_template_name_suffix" {
  description = "Launch template name suffix."
  type        = string
}

variable "eks_launch_template_update_default_version" {
  description = "Whether to update the launch template default version."
  type        = bool
}

variable "eks_launch_template_http_endpoint" {
  description = "EC2 metadata service HTTP endpoint."
  type        = string
}

variable "eks_launch_template_http_tokens" {
  description = "EC2 metadata service token requirement."
  type        = string
}

variable "eks_launch_template_monitoring_enabled" {
  description = "Whether detailed EC2 monitoring is enabled."
  type        = bool
}

variable "eks_launch_template_tag_resource_type" {
  description = "Resource type receiving launch template tags."
  type        = string
}

variable "eks_worker_node_name_suffix" {
  description = "Worker node Name tag suffix."
  type        = string
}

variable "eks_cpu_alarm_name_suffix" {
  description = "CPU alarm name suffix."
  type        = string
}

variable "eks_cpu_alarm_comparison_operator" {
  description = "CloudWatch CPU alarm comparison operator."
  type        = string
}

variable "eks_cpu_alarm_evaluation_periods" {
  description = "CPU alarm evaluation periods."
  type        = number
}

variable "eks_cpu_alarm_metric_name" {
  description = "CloudWatch CPU metric name."
  type        = string
}

variable "eks_cpu_alarm_namespace" {
  description = "CloudWatch CPU metric namespace."
  type        = string
}

variable "eks_cpu_alarm_period" {
  description = "CPU alarm evaluation period."
  type        = number
}

variable "eks_cpu_alarm_statistic" {
  description = "CPU alarm statistic."
  type        = string
}

variable "eks_cpu_alarm_threshold" {
  description = "CPU alarm threshold."
  type        = number
}

variable "eks_cpu_alarm_description" {
  description = "CPU alarm description."
  type        = string
}

variable "eks_cpu_alarm_treat_missing_data" {
  description = "CloudWatch missing data treatment."
  type        = string
}

variable "eks_disk_size" {
  description = "EBS root volume size in GiB for EKS managed nodes."
  type        = number

  validation {
    condition     = var.eks_disk_size >= 20
    error_message = "eks_disk_size must be at least 20 GiB."
  }
}

variable "eks_node_group_name_suffix" {
  description = "Suffix appended to the EKS managed node group name."
  type        = string
}

variable "eks_capacity_type" {
  description = "Capacity type used by EKS managed node groups."
  type        = string

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.eks_capacity_type)
    error_message = "eks_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "eks_ami_type" {
  description = "AMI type used by EKS managed node groups."
  type        = string
}

variable "eks_instance_types" {
  description = "EC2 instance types used by EKS managed node groups."
  type        = list(string)

  validation {
    condition     = length(var.eks_instance_types) > 0
    error_message = "eks_instance_types must contain at least one instance type."
  }
}

variable "eks_max_unavailable" {
  description = "Maximum number of unavailable nodes during node group updates."
  type        = number

  validation {
    condition     = var.eks_max_unavailable >= 1
    error_message = "eks_max_unavailable must be greater than or equal to 1."
  }
}

variable "eks_endpoint_private_access" {
  description = "Whether the EKS API endpoint has private access"
  type        = bool
}

variable "eks_endpoint_public_access" {
  description = "Whether the EKS API endpoint has public access"
  type        = bool
}

variable "eks_log_group_name_suffix" {
  description = "EKS CloudWatch log group name suffix."
  type        = string
}

variable "eks_log_retention_in_days" {
  description = "EKS CloudWatch log retention period."
  type        = number
}

variable "eks_log_group_name_prefix" {
  description = "Prefix used for the EKS CloudWatch log group name."
  type        = string
}

variable "eks_public_access_cidrs" {
  description = "CIDR ranges allowed to access the public EKS API endpoint."
  type        = list(string)
}

variable "karpenter_node_class_name" {
  description = "Name of the Karpenter EC2NodeClass."
  type        = string
  default     = null
}

variable "karpenter_ami_family" {
  description = "AMI family used by Karpenter."
  type        = string
  default     = null
}

variable "karpenter_ami_selector_alias" {
  description = "AMI selector alias used by Karpenter."
  type        = string
  default     = null
}

variable "karpenter_node_name_prefix" {
  description = "Name prefix for Karpenter-provisioned nodes."
  type        = string
  default     = null
}

variable "karpenter_discovery_tag_key" {
  description = "Tag key used by Karpenter to discover AWS resources."
  type        = string
  default     = null
}

variable "karpenter_node_pool_name" {
  description = "Name of the Karpenter NodePool."
  type        = string
  default     = null
}

variable "karpenter_node_pool_architecture" {
  description = "CPU architecture allowed for Karpenter nodes."
  type        = string
  default     = null
}

variable "karpenter_node_pool_operating_system" {
  description = "Operating system allowed for Karpenter nodes."
  type        = string
  default     = null
}

variable "karpenter_node_pool_capacity_types" {
  description = "Capacity types allowed for Karpenter nodes."
  type        = list(string)
  default     = null
}

variable "karpenter_consolidation_policy" {
  description = "Karpenter NodePool consolidation policy."
  type        = string
  default     = null
}

variable "karpenter_consolidate_after" {
  description = "How long Karpenter waits before consolidation."
  type        = string
  default     = null
}

variable "endpoint_ingress_cidrs" {
  description = "CIDR blocks allowed to access VPC endpoint security groups"
  type        = list(string)
}


variable "endpoint_protocol" {
  description = "Protocol used by Interface VPC Endpoint ingress"
  type        = string
}


variable "endpoint_egress_description" {
  description = "Description for endpoint security group egress rule"
  type        = string
}

variable "endpoint_port" {
  description = "Port used by interface VPC endpoints"
  type        = number
}


variable "endpoint_egress_from_port" {
  description = "Starting port for endpoint egress"
  type        = number
}

variable "endpoint_egress_to_port" {
  description = "Ending port for endpoint egress"
  type        = number
}

variable "endpoint_egress_protocol" {
  description = "Protocol used by endpoint egress"
  type        = string
}

variable "security_group_description" {
  description = "Description for VPC endpoint security group"
  type        = string
}

variable "enabled_cluster_log_types" {
  description = "EKS control plane log types to enable"
  type        = list(string)
}

variable "rds_db_identifier" {
  description = "RDS instance identifier"
  type        = string
}


variable "rds_engine" {
  type    = string
  default = "postgres"
}

variable "rds_engine_version" {
  type    = string
  default = "16"
}

variable "rds_parameter_group_family" {
  type    = string
  default = "postgres16"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "rds_allocated_storage" {
  type    = number
  default = 20
}

variable "rds_max_allocated_storage" {
  type    = number
  default = 50
}

variable "rds_storage_type" {
  type    = string
  default = "gp3"
}

variable "rds_database_name" {
  type    = string
  default = "applicationdb"
}

variable "rds_port" {
  type    = number
  default = 5432
}

variable "rds_multi_az" {
  type    = bool
  default = false
}

variable "rds_storage_encrypted" {
  type    = bool
  default = true
}

variable "rds_kms_key_id" {
  type    = string
  default = null
}

variable "rds_allowed_security_groups" {
  type    = list(string)
  default = []
}

variable "rds_backup_retention_period" {
  type    = number
  default = 7
}

variable "rds_performance_insights_enabled" {
  type    = bool
  default = false
}

variable "rds_monitoring_interval" {
  type    = number
  default = 0
}

variable "rds_deletion_protection" {
  type    = bool
  default = false
}

variable "rds_skip_final_snapshot" {
  type    = bool
  default = true
}

variable "rds_apply_immediately" {
  type    = bool
  default = true
}

variable "rds_iam_database_authentication_enabled" {
  type    = bool
  default = true
}

variable "rds_create_connect_role" {
  type    = bool
  default = false
}

variable "rds_secret_recovery_window_in_days" {
  type    = number
  default = 0
}


variable "rds_master_username" {
  description = "RDS master username"
  type        = string
}

variable "endpoint_ingress_description" {
  description = "Description for endpoint security group ingress rule"
  type        = string
}

variable "rds_log_connections" {
  description = "PostgreSQL log_connections parameter value."
  type        = string
}

variable "rds_log_disconnections" {
  description = "PostgreSQL log_disconnections parameter value."
  type        = string
}

variable "rds_log_statement" {
  description = "PostgreSQL log_statement parameter value."
  type        = string
}
variable "rds_backup_window" {
  description = "Preferred automated backup window"
  type        = string
}

variable "rds_maintenance_window" {
  description = "Preferred RDS maintenance window"
  type        = string
}

variable "ecr_kms_encryption_enabled" {
  description = "Whether ECR repository encryption uses KMS."
  type        = bool
}
