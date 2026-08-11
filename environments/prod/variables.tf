############################################################
# General / Environment
############################################################

variable "aws_region" {
  description = "AWS region for the environment."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "project_name" {
  description = "Project name."
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources."
  type        = map(string)
  default     = {}
}


############################################################
# VPC
############################################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones used by the environment."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
}

variable "public_subnet_tags" {
  description = "Tags applied to public subnets."
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Tags applied to private subnets."
  type        = map(string)
  default     = {}
}

variable "single_nat_gateway" {
  description = "Whether to create a single NAT Gateway instead of one per Availability Zone."
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Whether DNS hostnames are enabled for the VPC."
  type        = bool
}

variable "enable_dns_support" {
  description = "Whether DNS support is enabled for the VPC."
  type        = bool
}

variable "instance_tenancy" {
  description = "VPC instance tenancy."
  type        = string

  validation {
    condition = contains(
      ["default", "dedicated", "host"],
      var.instance_tenancy
    )

    error_message = "instance_tenancy must be default, dedicated, or host."
  }
}

variable "map_public_ip_on_launch" {
  description = "Whether public subnets assign public IP addresses on launch."
  type        = bool
}


############################################################
# VPC Endpoints
############################################################

variable "interface_endpoints" {
  description = "AWS services configured as interface VPC endpoints."
  type        = list(string)
}

variable "gateway_endpoints" {
  description = "AWS services configured as gateway VPC endpoints."
  type        = list(string)
}

variable "private_dns_enabled" {
  description = "Whether private DNS is enabled for interface endpoints."
  type        = bool
  default     = true
}

variable "endpoint_ingress_cidrs" {
  description = "CIDR blocks allowed to access VPC endpoint security groups."
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.endpoint_ingress_cidrs : can(cidrnetmask(cidr))
    ])

    error_message = "All endpoint ingress CIDRs must be valid CIDRs."
  }
}

variable "endpoint_egress_cidrs" {
  description = "CIDR blocks allowed for VPC endpoint egress."
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.endpoint_egress_cidrs : can(cidrnetmask(cidr))
    ])

    error_message = "All endpoint egress CIDRs must be valid CIDRs."
  }
}


############################################################
# EKS - Cluster
############################################################

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string

  validation {
    condition = can(
      regex("^[0-9]+\\.[0-9]+$", var.kubernetes_version)
    )

    error_message = "kubernetes_version must use the major.minor format, for example 1.31."
  }
}

variable "node_group_name" {
  description = "Name of the EKS managed node group."
  type        = string
}

variable "desired_size" {
  description = "Desired number of nodes in the managed node group."
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes in the managed node group."
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes in the managed node group."
  type        = number
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


############################################################
# EKS - Add-ons
############################################################

variable "eks_addons" {
  description = "EKS managed add-ons configured for this environment."

  type = map(object({
    addon_name                  = string
    addon_version               = optional(string)
    resolve_conflicts_on_create = string
    service_account_role_type   = string
  }))

  validation {
    condition = alltrue([
      for addon in values(var.eks_addons) :
      contains(
        ["OVERWRITE", "NONE"],
        addon.resolve_conflicts_on_create
      )
    ])

    error_message = "resolve_conflicts_on_create must be OVERWRITE or NONE."
  }

  validation {
    condition = alltrue([
      for addon in values(var.eks_addons) :
      contains(
        ["none", "ebs_csi"],
        addon.service_account_role_type
      )
    ])

    error_message = "service_account_role_type must be none or ebs_csi."
  }
}


############################################################
# Karpenter
############################################################

variable "karpenter_chart_version" {
  description = "Karpenter Helm chart version."
  type        = string
}


############################################################
# ECR - Repository
############################################################

variable "ecr_repository_name" {
  description = "Name of the ECR repository."
  type        = string

  validation {
    condition = can(
      regex(
        "^[a-z0-9]+([._*/-][a-z0-9]+)*$",
        trimspace(var.ecr_repository_name)
      )
    )

    error_message = "ecr_repository_name must contain only lowercase letters, numbers, '.', '_', '*', '/', or '-'."
  }
}

variable "ecr_image_tag_mutability" {
  description = "Whether ECR image tags are mutable or immutable."
  type        = string

  validation {
    condition = contains(
      ["MUTABLE", "IMMUTABLE"],
      var.ecr_image_tag_mutability
    )

    error_message = "ecr_image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "ecr_scan_on_push" {
  description = "Whether basic ECR image scanning is enabled on image push."
  type        = bool
}

variable "ecr_force_delete" {
  description = "Whether Terraform can delete the ECR repository when it contains images."
  type        = bool
}


############################################################
# ECR - Enhanced Scanning
############################################################

variable "ecr_enhanced_scanning_enabled" {
  description = "Whether Amazon Inspector enhanced ECR scanning is enabled."
  type        = bool
}

variable "ecr_enhanced_scanning_type" {
  description = "Enhanced ECR scanning frequency."
  type        = string

  validation {
    condition = contains(
      ["CONTINUOUS_SCAN", "SCAN_ON_PUSH"],
      var.ecr_enhanced_scanning_type
    )

    error_message = "ecr_enhanced_scanning_type must be CONTINUOUS_SCAN or SCAN_ON_PUSH."
  }
}

variable "ecr_enhanced_scanning_scan_type" {
  description = "ECR registry scanning configuration type."
  type        = string
}

variable "ecr_enhanced_scanning_filter_type" {
  description = "ECR repository filter type used by enhanced scanning."
  type        = string
}


############################################################
# ECR - Encryption
############################################################

variable "ecr_encryption_type" {
  description = "Encryption type used by the ECR repository."
  type        = string

  validation {
    condition = contains(
      ["AES256", "KMS"],
      var.ecr_encryption_type
    )

    error_message = "ecr_encryption_type must be AES256 or KMS."
  }
}

variable "ecr_kms_key_arn" {
  description = "KMS key ARN used when ECR encryption type is KMS."
  type        = string
  default     = null

  validation {
    condition = (
      var.ecr_kms_key_arn == null ||
      can(
        regex(
          "^arn:[^:]+:kms:[^:]+:[0-9]{12}:key/.+$",
          var.ecr_kms_key_arn
        )
      )
    )

    error_message = "ecr_kms_key_arn must be a valid KMS key ARN or null."
  }
}


############################################################
# ECR - Repository Access
############################################################

variable "ecr_repository_read_principals" {
  description = "IAM principals allowed to pull images from ECR."
  type        = list(string)
  default     = []
}

variable "ecr_repository_write_principals" {
  description = "IAM principals allowed to push images to ECR."
  type        = list(string)
  default     = []
}


############################################################
# ECR - Lifecycle
############################################################

variable "ecr_lifecycle_rule_priority" {
  description = "Priority of the ECR lifecycle rule."
  type        = number

  validation {
    condition     = var.ecr_lifecycle_rule_priority >= 1
    error_message = "ecr_lifecycle_rule_priority must be greater than or equal to 1."
  }
}

variable "ecr_lifecycle_description" {
  description = "Description of the ECR lifecycle rule."
  type        = string
}

variable "ecr_lifecycle_tag_status" {
  description = "Tag status selection used by the ECR lifecycle rule."
  type        = string

  validation {
    condition = contains(
      ["tagged", "untagged", "any"],
      var.ecr_lifecycle_tag_status
    )

    error_message = "ecr_lifecycle_tag_status must be tagged, untagged, or any."
  }
}

variable "ecr_lifecycle_count_type" {
  description = "Count type used by the ECR lifecycle rule."
  type        = string

  validation {
    condition = contains(
      ["imageCountMoreThan", "sinceImagePushed"],
      var.ecr_lifecycle_count_type
    )

    error_message = "ecr_lifecycle_count_type must be imageCountMoreThan or sinceImagePushed."
  }
}

variable "ecr_lifecycle_max_image_count" {
  description = "Maximum number of ECR images retained."
  type        = number

  validation {
    condition     = var.ecr_lifecycle_max_image_count >= 1
    error_message = "ecr_lifecycle_max_image_count must be greater than or equal to 1."
  }
}

variable "ecr_lifecycle_action_type" {
  description = "Action performed when the ECR lifecycle rule matches."
  type        = string

  validation {
    condition     = var.ecr_lifecycle_action_type == "expire"
    error_message = "ecr_lifecycle_action_type must be expire."
  }
}


############################################################
# ECR - Resource Tag Configuration
############################################################

variable "ecr_managed_by" {
  description = "Value used for the ECR ManagedBy tag."
  type        = string
}

variable "ecr_module_name" {
  description = "Value used for the ECR Module tag."
  type        = string
}


############################################################
# EKS - IAM Assume Role Configuration
############################################################

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


############################################################
# EKS - IAM Role Naming
############################################################

variable "eks_cluster_role_name_suffix" {
  description = "Suffix used for the EKS cluster IAM role name."
  type        = string
}

variable "eks_node_role_name_suffix" {
  description = "Suffix used for the EKS node IAM role name."
  type        = string
}


############################################################
# EKS - IAM Managed Policies
############################################################

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

############################################################
# EKS Common Tags
############################################################

variable "eks_managed_by" {
  description = "ManagedBy tag value for EKS resources."
  type        = string
}

variable "eks_module_name" {
  description = "Module tag value for EKS resources."
  type        = string
}

############################################################
# EKS Launch Template
############################################################

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

############################################################
# EKS CloudWatch CPU Alarm
############################################################

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

############################################################
# EKS CloudWatch Log Group
############################################################

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
