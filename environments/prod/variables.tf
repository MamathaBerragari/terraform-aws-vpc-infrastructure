variable "aws_region" {
  type = string
}

variable "interface_endpoints" {
  type = list(string)
}

variable "gateway_endpoints" {
  type = list(string)
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

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_dns_enabled" {
  type    = bool
  default = true
}

variable "endpoint_ingress_cidrs" {
  type = list(string)
}


variable "project_name" {
  type = string
}

variable "tags" {

  description = "Common tags"

  type = map(string)

  default = {}

}

variable "single_nat_gateway" {
  description = "Create a single NAT Gateway or one NAT Gateway per Availability Zone"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS support for the VPC"
  type        = bool
}

variable "instance_tenancy" {
  description = "VPC instance tenancy"
  type        = string

  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "instance_tenancy must be default, dedicated, or host."
  }
}

variable "map_public_ip_on_launch" {
  description = "Whether public subnets assign public IP addresses"
  type        = bool
}

variable "endpoint_egress_cidrs" {
  description = "CIDRs allowed for VPC endpoint egress"
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.endpoint_egress_cidrs : can(cidrnetmask(cidr))
    ])
    error_message = "All endpoint egress CIDRs must be valid CIDRs."
  }
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+([._/-][a-z0-9]+)*$", trimspace(var.ecr_repository_name)))
    error_message = "ECR repository name must contain only lowercase letters, numbers, '.', '_' or '/'."
  }
}

variable "ecr_image_tag_mutability" {
  description = "ECR image tag mutability"
  type        = string

  validation {
    condition = contains(
      ["MUTABLE", "IMMUTABLE"],
      var.ecr_image_tag_mutability
    )

    error_message = "ECR image tag mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "ecr_scan_on_push" {
  description = "Enable ECR image scanning on push"
  type        = bool
}

variable "ecr_enhanced_scanning_enabled" {
  description = "Enable Amazon Inspector enhanced ECR scanning."
  type        = bool
}

variable "ecr_enhanced_scanning_type" {
  description = "ECR enhanced scanning frequency."
  type        = string

  validation {
    condition = contains(
      ["CONTINUOUS_SCAN", "SCAN_ON_PUSH"],
      var.ecr_enhanced_scanning_type
    )

    error_message = "ECR enhanced scanning type must be CONTINUOUS_SCAN or SCAN_ON_PUSH."
  }
}

variable "ecr_encryption_type" {
  description = "ECR repository encryption type."
  type        = string

  validation {
    condition = contains(
      ["AES256", "KMS"],
      var.ecr_encryption_type
    )

    error_message = "ECR encryption type must be AES256 or KMS."
  }
}

variable "ecr_kms_key_arn" {
  description = "KMS key ARN used for ECR encryption when KMS encryption is enabled."
  type        = string
  default     = null
}

variable "ecr_lifecycle_max_image_count" {
  description = "Maximum number of ECR images retained."
  type        = number

  validation {
    condition     = var.ecr_lifecycle_max_image_count >= 1
    error_message = "ECR lifecycle image count must be greater than zero."
  }
}

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

variable "eks_addons" {
  description = "EKS managed add-ons to install for this environment."

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

variable "ecr_lifecycle_rule_priority" {
  description = "Priority of the ECR lifecycle rule."
  type        = number

  validation {
    condition     = var.ecr_lifecycle_rule_priority >= 1
    error_message = "ECR lifecycle rule priority must be greater than or equal to 1."
  }
}

variable "ecr_lifecycle_description" {
  description = "Description of the ECR lifecycle rule."
  type        = string
}

variable "ecr_lifecycle_tag_status" {
  description = "Tag status selection for the ECR lifecycle rule."
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

    error_message = "Invalid ECR lifecycle count type."
  }
}


variable "ecr_lifecycle_action_type" {
  description = "Action performed when the ECR lifecycle rule matches."
  type        = string

  validation {
    condition     = var.ecr_lifecycle_action_type == "expire"
    error_message = "ECR lifecycle action type must be expire."
  }
}
