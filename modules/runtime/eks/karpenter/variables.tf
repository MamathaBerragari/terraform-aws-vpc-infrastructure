variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS API Endpoint"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "Cluster CA Certificate"
  type        = string
}

variable "cluster_oidc_provider_arn" {
  description = "OIDC Provider ARN"
  type        = string
}

variable "cluster_oidc_provider_url" {
  description = "OIDC Provider URL"
  type        = string
}

variable "node_role_arn" {
  description = "Worker Node IAM Role ARN"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnets"
  type        = list(string)
}

variable "node_security_group_id" {
  description = "Worker Node Security Group"
  type        = string
}

variable "tags" {
  description = "Common Tags"

  type = map(string)

  default = {}
}
