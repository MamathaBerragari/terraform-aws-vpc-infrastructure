variable "repository_name" {
  description = "Name of the ECR repository."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+([._/-][a-z0-9]+)*$", trimspace(var.repository_name)))
    error_message = "repository_name must contain only lowercase letters, numbers, '.', '_' or '/'."
  }
}

variable "image_tag_mutability" {
  description = "Whether ECR image tags are mutable or immutable."
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition = contains(
      ["MUTABLE", "IMMUTABLE"],
      var.image_tag_mutability
    )

    error_message = "image_tag_mutability must be either MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable basic ECR image scanning when images are pushed."
  type        = bool
  default     = true
}

variable "enhanced_scanning_enabled" {
  description = "Enable Amazon Inspector enhanced scanning for the repository."
  type        = bool
  default     = false
}

variable "enhanced_scanning_type" {
  description = "Enhanced ECR scanning type."
  type        = string
  default     = "CONTINUOUS_SCAN"

  validation {
    condition = contains(
      ["CONTINUOUS_SCAN", "SCAN_ON_PUSH"],
      var.enhanced_scanning_type
    )

    error_message = "enhanced_scanning_type must be CONTINUOUS_SCAN or SCAN_ON_PUSH."
  }
}

variable "repository_read_principals" {
  description = "IAM principals allowed to pull images from the repository."
  type        = list(string)
  default     = []
}

variable "repository_write_principals" {
  description = "IAM principals allowed to push images to the repository."
  type        = list(string)
  default     = []
}

variable "encryption_type" {
  description = "ECR repository encryption type."
  type        = string
  default     = "AES256"

  validation {
    condition = contains(
      ["AES256", "KMS"],
      var.encryption_type
    )

    error_message = "encryption_type must be AES256 or KMS."
  }
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used for ECR encryption when encryption_type is KMS."
  type        = string
  default     = null

  validation {
    condition = (
      var.kms_key_arn == null ||
      can(regex("^arn:[^:]+:kms:[^:]+:[0-9]{12}:key/.+$", var.kms_key_arn))
    )

    error_message = "kms_key_arn must be a valid KMS key ARN or null."
  }
}

variable "tags" {
  description = "Common tags applied to ECR resources."
  type        = map(string)
  default     = {}
}

variable "lifecycle_rule_priority" {
  description = "Priority of the ECR lifecycle rule."
  type        = number
}

variable "lifecycle_description" {
  description = "Description of the ECR lifecycle rule."
  type        = string
}

variable "lifecycle_tag_status" {
  description = "Tag status selection for the ECR lifecycle rule."
  type        = string
}

variable "lifecycle_count_type" {
  description = "Count type used by the ECR lifecycle rule."
  type        = string
}


variable "lifecycle_action_type" {
  description = "Action performed by the ECR lifecycle rule."
  type        = string
}

variable "lifecycle_max_image_count" {
  description = "Maximum number of images retained in the repository."
  type        = number

  validation {
    condition     = var.lifecycle_max_image_count >= 1
    error_message = "lifecycle_max_image_count must be greater than or equal to 1."
  }
}


variable "managed_by" {
  description = "Value used for the ManagedBy resource tag."
  type        = string
}

variable "module_name" {
  description = "Value used for the Module resource tag."
  type        = string
}
