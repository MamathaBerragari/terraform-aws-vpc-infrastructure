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
# Add-ons
###############################################################

variable "enable_vpc_cni" {
  type    = bool
  default = true
}

variable "enable_coredns" {
  type    = bool
  default = true
}

variable "enable_kube_proxy" {
  type    = bool
  default = true
}

variable "enable_ebs_csi_driver" {
  type    = bool
  default = true
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
