variable "region" {
  description = "AWS region for the EKS environment"
  type        = string

  validation {
    condition     = length(trimspace(var.region)) > 0
    error_message = "Region must not be empty."
  }
}

###############################################################
# Cluster Configuration
###############################################################

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+$", var.cluster_version))
    error_message = "cluster_version must be in major.minor format, for example 1.31."
  }
}

variable "ip_family" {
  description = "IP address family used by the EKS cluster"
  type        = string

  validation {
    condition     = contains(["ipv4", "ipv6"], var.ip_family)
    error_message = "ip_family must be either ipv4 or ipv6."
  }
}

variable "authentication_mode" {
  description = "EKS authentication mode"
  type        = string

  validation {
    condition = contains(
      ["CONFIG_MAP", "API", "API_AND_CONFIG_MAP"],
      var.authentication_mode
    )

    error_message = "authentication_mode must be CONFIG_MAP, API, or API_AND_CONFIG_MAP."
  }
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "Whether the cluster creator receives bootstrap administrator permissions"
  type        = bool
}

###############################################################
# IAM Assume Role Configuration
###############################################################

variable "cluster_assume_role_actions" {
  description = "IAM actions allowed in the EKS cluster assume role policy"
  type        = list(string)
}

variable "cluster_assume_role_principal_type" {
  description = "Principal type for the EKS cluster IAM role"
  type        = string
}

variable "cluster_assume_role_principal_identifiers" {
  description = "Principal identifiers for the EKS cluster IAM role"
  type        = list(string)
}

variable "node_assume_role_actions" {
  description = "IAM actions allowed in the EKS node assume role policy"
  type        = list(string)
}

variable "node_assume_role_principal_type" {
  description = "Principal type for the EKS node IAM role"
  type        = string
}

variable "node_assume_role_principal_identifiers" {
  description = "Principal identifiers for the EKS node IAM role"
  type        = list(string)
}

###############################################################
# IAM Role Naming
###############################################################

variable "cluster_role_name_suffix" {
  description = "Suffix used for the EKS cluster IAM role name"
  type        = string
}

variable "node_role_name_suffix" {
  description = "Suffix used for the EKS node IAM role name"
  type        = string
}

###############################################################
# EKS IAM Managed Policies
###############################################################

variable "cluster_policy_arn" {
  description = "AWS managed IAM policy ARN attached to the EKS cluster role"
  type        = string
}

variable "worker_node_policy_arn" {
  description = "AWS managed IAM policy ARN attached to EKS worker nodes"
  type        = string
}

variable "cni_policy_arn" {
  description = "AWS managed IAM policy ARN attached to EKS worker nodes for VPC CNI"
  type        = string
}

variable "ecr_read_policy_arn" {
  description = "AWS managed IAM policy ARN attached to EKS worker nodes for ECR read access"
  type        = string
}

###############################################################
# Networking
###############################################################

variable "vpc_id" {
  description = "VPC ID used by the EKS cluster"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by EKS worker nodes"
  type        = list(string)
}

variable "control_plane_subnet_ids" {
  description = "Subnet IDs used by the EKS control plane"
  type        = list(string)
}

###############################################################
# API Endpoint
###############################################################

variable "endpoint_private_access" {
  description = "Whether the EKS API endpoint has private access"
  type        = bool
}

variable "endpoint_public_access" {
  description = "Whether the EKS API endpoint has public access"
  type        = bool
}

variable "public_access_cidrs" {
  description = "CIDRs allowed to access the public EKS API endpoint"
  type        = list(string)
}

###############################################################
# Managed Node Group
###############################################################

variable "node_group_name" {
  description = "Managed node group name"
  type        = string
}

variable "instance_types" {
  description = "EC2 instance types for the managed node group"
  type        = list(string)
}

variable "capacity_type" {
  description = "Capacity type for the managed node group"
  type        = string

  validation {
    condition = contains(
      ["ON_DEMAND", "SPOT"],
      var.capacity_type
    )

    error_message = "capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number

  validation {
    condition     = var.desired_size >= 0
    error_message = "desired_size must be zero or greater."
  }
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number

  validation {
    condition     = var.min_size >= 0
    error_message = "min_size must be zero or greater."
  }
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number

  validation {
    condition     = var.max_size >= var.min_size
    error_message = "max_size must be greater than or equal to min_size."
  }
}

variable "disk_size" {
  description = "Root volume size of managed node group instances in GiB"
  type        = number

  validation {
    condition     = var.disk_size > 0
    error_message = "disk_size must be greater than zero."
  }
}
variable "node_group_name_suffix" {
  description = "Suffix appended to the managed EKS node group name"
  type        = string
}

variable "max_unavailable" {
  description = "Maximum number of unavailable nodes during node group updates"
  type        = number

  validation {
    condition     = var.max_unavailable >= 1
    error_message = "max_unavailable must be greater than or equal to 1."
  }
}


###############################################################
# Launch Template
###############################################################

variable "ami_type" {
  description = "AMI type for the managed node group"
  type        = string
}

###############################################################
# EKS Common Tag Configuration
###############################################################

variable "managed_by" {
  description = "Value used for the ManagedBy tag"
  type        = string
}

variable "module_name" {
  description = "Value used for the Module tag"
  type        = string
}

###############################################################
# EKS Launch Template Configuration
###############################################################

variable "launch_template_name_suffix" {
  description = "Suffix appended to the EKS launch template name"
  type        = string
}

variable "launch_template_update_default_version" {
  description = "Whether the launch template should update its default version"
  type        = bool
}

variable "launch_template_http_endpoint" {
  description = "EC2 instance metadata service HTTP endpoint configuration"
  type        = string

  validation {
    condition = contains(
      ["enabled", "disabled"],
      var.launch_template_http_endpoint
    )

    error_message = "launch_template_http_endpoint must be enabled or disabled."
  }
}

variable "launch_template_http_tokens" {
  description = "EC2 instance metadata service token requirement"
  type        = string

  validation {
    condition = contains(
      ["optional", "required"],
      var.launch_template_http_tokens
    )

    error_message = "launch_template_http_tokens must be optional or required."
  }
}

variable "launch_template_monitoring_enabled" {
  description = "Whether detailed EC2 instance monitoring is enabled"
  type        = bool
}

variable "launch_template_tag_resource_type" {
  description = "AWS resource type receiving launch template tags"
  type        = string
}

variable "worker_node_name_suffix" {
  description = "Suffix appended to the worker node Name tag"
  type        = string
}

###############################################################
# EKS CloudWatch CPU Alarm Configuration
###############################################################

variable "cpu_alarm_name_suffix" {
  description = "Suffix appended to the EKS CPU alarm name"
  type        = string
}

variable "cpu_alarm_comparison_operator" {
  description = "CloudWatch alarm comparison operator"
  type        = string
}

variable "cpu_alarm_evaluation_periods" {
  description = "Number of evaluation periods for the CPU alarm"
  type        = number
}

variable "cpu_alarm_metric_name" {
  description = "CloudWatch metric name for the CPU alarm"
  type        = string
}

variable "cpu_alarm_namespace" {
  description = "CloudWatch namespace for the CPU alarm"
  type        = string
}

variable "cpu_alarm_period" {
  description = "CloudWatch alarm evaluation period in seconds"
  type        = number
}

variable "cpu_alarm_statistic" {
  description = "CloudWatch statistic used by the CPU alarm"
  type        = string
}

variable "cpu_alarm_threshold" {
  description = "CPU utilization threshold for the CloudWatch alarm"
  type        = number
}

variable "cpu_alarm_description" {
  description = "Description of the EKS CPU CloudWatch alarm"
  type        = string
}

variable "cpu_alarm_treat_missing_data" {
  description = "How CloudWatch handles missing metric data"
  type        = string
}

###############################################################
# EKS CloudWatch Log Group Configuration
###############################################################

variable "eks_log_group_name_suffix" {
  description = "Suffix appended to the EKS CloudWatch log group name"
  type        = string
}

variable "eks_log_retention_in_days" {
  description = "Number of days EKS CloudWatch logs are retained"
  type        = number

  validation {
    condition     = var.eks_log_retention_in_days > 0
    error_message = "eks_log_retention_in_days must be greater than zero."
  }
}

variable "eks_log_group_name_prefix" {
  description = "Prefix used for the EKS CloudWatch log group name"
  type        = string
}

###############################################################
# Logging
###############################################################

variable "enabled_cluster_log_types" {
  description = "EKS control plane log types enabled for the cluster"
  type        = list(string)

  validation {
    condition = alltrue([
      for log_type in var.enabled_cluster_log_types :
      contains(
        [
          "api",
          "audit",
          "authenticator",
          "controllerManager",
          "scheduler"
        ],
        log_type
      )
    ])

    error_message = "enabled_cluster_log_types contains an unsupported EKS control plane log type."
  }
}

###############################################################
# EKS Add-ons
###############################################################

variable "eks_addons" {
  description = "EKS managed add-ons to install"

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

###############################################################
# Tags
###############################################################

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

###############################################################
# Karpenter
###############################################################

variable "kubernetes_version" {
  description = "Kubernetes version used by Karpenter"

  type = string

  validation {
    condition = can(
      regex(
        "^[0-9]+\\.[0-9]+$",
        var.kubernetes_version
      )
    )

    error_message = "kubernetes_version must be in major.minor format, for example 1.31."
  }
}

variable "karpenter_chart_version" {
  description = "Karpenter Helm chart version"
  type        = string

  validation {
    condition     = length(trimspace(var.karpenter_chart_version)) > 0
    error_message = "karpenter_chart_version must not be empty."
  }
}



variable "karpenter_node_class_name" {
  description = "Name of the Karpenter EC2NodeClass."
  type        = string
}

variable "karpenter_ami_family" {
  description = "AMI family used by Karpenter."
  type        = string
}

variable "karpenter_ami_selector_alias" {
  description = "AMI selector alias used by Karpenter."
  type        = string
}

variable "karpenter_node_name_prefix" {
  description = "Name prefix for Karpenter-provisioned nodes."
  type        = string
}

variable "karpenter_discovery_tag_key" {
  description = "Tag key used by Karpenter to discover AWS resources."
  type        = string
}

variable "karpenter_node_pool_name" {
  description = "Name of the Karpenter NodePool."
  type        = string
}

variable "karpenter_node_pool_architecture" {
  description = "CPU architecture allowed for Karpenter nodes."
  type        = string
}

variable "karpenter_node_pool_operating_system" {
  description = "Operating system allowed for Karpenter nodes."
  type        = string
}

variable "karpenter_node_pool_capacity_types" {
  description = "Capacity types allowed for Karpenter nodes."
  type        = list(string)
}

variable "karpenter_consolidation_policy" {
  description = "Karpenter NodePool consolidation policy."
  type        = string
}

variable "karpenter_consolidate_after" {
  description = "How long Karpenter waits before consolidation."
  type        = string
}

variable "enable_karpenter" {
  description = "Whether to deploy Karpenter."
  type        = bool
  default     = false
}
