variable "region" {
  description = "AWS region for Karpenter"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}


variable "karpenter_version" {
  description = "Karpenter Helm Chart Version"
  type        = string
}


variable "tags" {
  description = "Common tags"
  type        = map(string)
}


variable "oidc_provider_arn" {
  description = "EKS OIDC Provider ARN"
  type        = string
}


variable "oidc_provider_url" {
  description = "EKS OIDC Provider URL"
  type        = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

variable "node_class_name" {
  description = "Name of the Karpenter EC2NodeClass."
  type        = string
}

variable "ami_family" {
  description = "AMI family used by the Karpenter EC2NodeClass."
  type        = string
}

variable "ami_selector_alias" {
  description = "AMI alias used by the Karpenter EC2NodeClass."
  type        = string
}

variable "node_name_prefix" {
  description = "Name prefix applied to Karpenter-provisioned nodes."
  type        = string
}

variable "discovery_tag_key" {
  description = "Tag key used by Karpenter to discover subnets and security groups."
  type        = string
}


variable "node_pool_name" {
  description = "Name of the Karpenter NodePool."
  type        = string
}

variable "node_pool_architecture" {
  description = "CPU architecture allowed for Karpenter nodes."
  type        = string
}

variable "node_pool_operating_system" {
  description = "Operating system allowed for Karpenter nodes."
  type        = string
}

variable "node_pool_capacity_types" {
  description = "Capacity types allowed for Karpenter nodes."
  type        = list(string)

  validation {
    condition = alltrue([
      for capacity_type in var.node_pool_capacity_types :
      contains(["on-demand", "spot"], capacity_type)
    ])

    error_message = "node_pool_capacity_types must contain only on-demand or spot."
  }
}

variable "consolidation_policy" {
  description = "Karpenter NodePool consolidation policy."
  type        = string
}

variable "consolidate_after" {
  description = "Time Karpenter waits before consolidating empty nodes."
  type        = string
}
