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
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes Version"
  type        = string
  default     = "1.31"
}

variable "ip_family" {
  description = "IP address family used by the EKS cluster."
  type        = string

  validation {
    condition     = contains(["ipv4", "ipv6"], var.ip_family)
    error_message = "ip_family must be either ipv4 or ipv6."
  }
}

variable "authentication_mode" {
  description = "EKS authentication mode."
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
  description = "Whether the cluster creator receives bootstrap administrator permissions."
  type        = bool
}


############################################################
# IAM Assume Role Configuration
############################################################

variable "cluster_assume_role_actions" {
  description = "IAM actions allowed in the EKS cluster assume role policy."
  type        = list(string)
}

variable "cluster_assume_role_principal_type" {
  description = "Principal type for the EKS cluster IAM role."
  type        = string
}

variable "cluster_assume_role_principal_identifiers" {
  description = "Principal identifiers for the EKS cluster IAM role."
  type        = list(string)
}

variable "node_assume_role_actions" {
  description = "IAM actions allowed in the EKS node assume role policy."
  type        = list(string)
}

variable "node_assume_role_principal_type" {
  description = "Principal type for the EKS node IAM role."
  type        = string
}

variable "node_assume_role_principal_identifiers" {
  description = "Principal identifiers for the EKS node IAM role."
  type        = list(string)
}

############################################################
# IAM Role Naming
############################################################

variable "cluster_role_name_suffix" {
  description = "Suffix used for the EKS cluster IAM role name."
  type        = string
}

variable "node_role_name_suffix" {
  description = "Suffix used for the EKS node IAM role name."
  type        = string
}

############################################################
# EKS IAM Managed Policies
############################################################

variable "cluster_policy_arn" {
  description = "AWS managed IAM policy ARN attached to the EKS cluster role."
  type        = string
}

variable "worker_node_policy_arn" {
  description = "AWS managed IAM policy ARN attached to EKS worker nodes."
  type        = string
}

variable "cni_policy_arn" {
  description = "AWS managed IAM policy ARN attached to EKS worker nodes for VPC CNI."
  type        = string
}

variable "ecr_read_policy_arn" {
  description = "AWS managed IAM policy ARN attached to EKS worker nodes for ECR read access."
  type        = string
}


###############################################################
# Networking
###############################################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "control_plane_subnet_ids" {
  description = "Subnets used by the EKS Control Plane"
  type        = list(string)
  default     = []
}

###############################################################
# API Endpoint
###############################################################

variable "endpoint_private_access" {
  description = "Enable Private API Endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable Public API Endpoint"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "Allowed Public CIDRs"
  type        = list(string)
  default     = []
}

###############################################################
# Node Group
###############################################################

variable "node_group_name" {
  description = "Managed Node Group Name"
  type        = string
}

variable "instance_types" {
  description = "EC2 Instance Types"
  type        = list(string)
  default     = ["t3.large"]
}

variable "capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_size" {
  description = "Desired Nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum Nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum Nodes"
  type        = number
  default     = 6
}

variable "disk_size" {
  description = "Root Volume Size"
  type        = number
  default     = 50
}

###############################################################
# Launch Template
###############################################################

variable "ami_type" {
  description = "AMI Type"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}



############################################################
# EKS Common Tag Configuration
############################################################

variable "managed_by" {
  description = "Value used for the ManagedBy tag."
  type        = string
}

variable "module_name" {
  description = "Value used for the Module tag."
  type        = string
}

############################################################
# EKS Launch Template Configuration
############################################################

variable "launch_template_name_suffix" {
  description = "Suffix appended to the EKS launch template name."
  type        = string
}

variable "launch_template_update_default_version" {
  description = "Whether the launch template should update its default version."
  type        = bool
}

variable "launch_template_http_endpoint" {
  description = "EC2 instance metadata service HTTP endpoint configuration."
  type        = string

  validation {
    condition     = contains(["enabled", "disabled"], var.launch_template_http_endpoint)
    error_message = "launch_template_http_endpoint must be enabled or disabled."
  }
}

variable "launch_template_http_tokens" {
  description = "EC2 instance metadata service token requirement."
  type        = string

  validation {
    condition     = contains(["optional", "required"], var.launch_template_http_tokens)
    error_message = "launch_template_http_tokens must be optional or required."
  }
}

variable "launch_template_monitoring_enabled" {
  description = "Whether detailed EC2 instance monitoring is enabled."
  type        = bool
}

variable "launch_template_tag_resource_type" {
  description = "AWS resource type receiving launch template tags."
  type        = string
}

variable "worker_node_name_suffix" {
  description = "Suffix appended to the worker node Name tag."
  type        = string
}

############################################################
# EKS CloudWatch CPU Alarm Configuration
############################################################

variable "cpu_alarm_name_suffix" {
  description = "Suffix appended to the EKS CPU alarm name."
  type        = string
}

variable "cpu_alarm_comparison_operator" {
  description = "CloudWatch alarm comparison operator."
  type        = string
}

variable "cpu_alarm_evaluation_periods" {
  description = "Number of evaluation periods for the CPU alarm."
  type        = number
}

variable "cpu_alarm_metric_name" {
  description = "CloudWatch metric name for the CPU alarm."
  type        = string
}

variable "cpu_alarm_namespace" {
  description = "CloudWatch namespace for the CPU alarm."
  type        = string
}

variable "cpu_alarm_period" {
  description = "CloudWatch alarm evaluation period in seconds."
  type        = number
}

variable "cpu_alarm_statistic" {
  description = "CloudWatch statistic used by the CPU alarm."
  type        = string
}

variable "cpu_alarm_threshold" {
  description = "CPU utilization threshold for the CloudWatch alarm."
  type        = number
}

variable "cpu_alarm_description" {
  description = "Description of the EKS CPU CloudWatch alarm."
  type        = string
}

variable "cpu_alarm_treat_missing_data" {
  description = "How CloudWatch handles missing metric data."
  type        = string
}

############################################################
# EKS CloudWatch Log Group Configuration
############################################################

variable "eks_log_group_name_suffix" {
  description = "Suffix appended to the EKS CloudWatch log group name."
  type        = string
}

variable "eks_log_retention_in_days" {
  description = "Number of days EKS CloudWatch logs are retained."
  type        = number

  validation {
    condition     = var.eks_log_retention_in_days > 0
    error_message = "eks_log_retention_in_days must be greater than zero."
  }
}

variable "eks_log_group_name_prefix" {
  description = "Prefix used for the EKS CloudWatch log group name."
  type        = string
}


###############################################################
# Logging
###############################################################

variable "enabled_cluster_log_types" {
  description = "Control Plane Logs"
  type        = list(string)

  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}
###############################################################
# EKS Add-ons
###############################################################

variable "eks_addons" {
  description = "EKS managed add-ons to install."

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
  description = "Common Tags"
  type        = map(string)
  default     = {}
}

###############################################################
# Karpenter
###############################################################

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."

  type = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+$", var.kubernetes_version))
    error_message = "kubernetes_version must be in the format major.minor, for example 1.31."
  }
}

variable "karpenter_chart_version" {
  description = "Karpenter Helm chart version."

  type = string

  validation {
    condition     = length(trimspace(var.karpenter_chart_version)) > 0
    error_message = "karpenter_chart_version must not be empty."
  }
}
