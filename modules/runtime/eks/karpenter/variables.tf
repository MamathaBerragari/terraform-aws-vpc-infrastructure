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
  default     = "1.3.3"
}


variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
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
