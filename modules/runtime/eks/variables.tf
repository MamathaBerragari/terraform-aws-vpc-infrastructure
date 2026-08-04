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
  default     = false
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
# Security
###############################################################

variable "kms_key_arn" {
  description = "Existing KMS Key ARN"
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
