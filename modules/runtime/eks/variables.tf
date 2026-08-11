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
