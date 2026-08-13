############################################################
# ECR Repository
############################################################

variable "repository_name" {
  description = "Name of the ECR repository."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+([._*/-][a-z0-9]+)*$", trimspace(var.repository_name)))
    error_message = "repository_name must contain only lowercase letters, numbers, '.', '_', '*', '/', or '-'."
  }
}

variable "image_tag_mutability" {
  description = "Whether ECR image tags are mutable or immutable."
  type        = string

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be either MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable basic ECR image scanning when images are pushed."
  type        = bool
}

variable "enhanced_scanning_enabled" {
  description = "Enable Amazon Inspector enhanced scanning."
  type        = bool
}

variable "enhanced_scanning_type" {
  description = "Enhanced ECR scanning frequency."
  type        = string
}

variable "repository_read_principals" {
  description = "IAM principals allowed to pull images from the repository."
  type        = list(string)
}

variable "repository_write_principals" {
  description = "IAM principals allowed to push images to the repository."
  type        = list(string)
}

variable "encryption_type" {
  description = "ECR repository encryption type."
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN used when ECR encryption type is KMS."
  type        = string
  nullable    = true

  validation {
    condition = (
      var.kms_key_arn == null ||
      can(regex("^arn:[^:]+:kms:[^:]+:[0-9]{12}:key/.+$", var.kms_key_arn))
    )

    error_message = "kms_key_arn must be a valid KMS key ARN or null."
  }
}

############################################################
# ECR Lifecycle Configuration
############################################################

variable "lifecycle_description" {
  description = "Description of the ECR lifecycle rule."
  type        = string
}

variable "lifecycle_tag_status" {
  description = "Tag status used by the ECR lifecycle rule."
  type        = string

  validation {
    condition = contains(
      ["tagged", "untagged", "any"],
      var.lifecycle_tag_status
    )

    error_message = "lifecycle_tag_status must be tagged, untagged, or any."
  }
}

variable "lifecycle_count_type" {
  description = "Count type used by the ECR lifecycle rule."
  type        = string
}

variable "lifecycle_max_image_count" {
  description = "Maximum number of images retained by the lifecycle rule."
  type        = number

  validation {
    condition     = var.lifecycle_max_image_count >= 1
    error_message = "lifecycle_max_image_count must be greater than or equal to 1."
  }
}

variable "lifecycle_action_type" {
  description = "Action performed by the ECR lifecycle rule."
  type        = string
}

variable "lifecycle_rule_priority" {
  description = "Priority of the ECR lifecycle rule."
  type        = number

  validation {
    condition     = var.lifecycle_rule_priority >= 1
    error_message = "lifecycle_rule_priority must be greater than or equal to 1."
  }
}



############################################################
# Resource Tag Configuration
############################################################

variable "managed_by" {
  description = "Value used for the ManagedBy resource tag."
  type        = string
}

variable "module_name" {
  description = "Value used for the Module resource tag."
  type        = string
}

############################################################
# Repository Deletion Configuration
############################################################

variable "force_delete" {
  description = "Whether Terraform is allowed to delete the ECR repository when it contains images."
  type        = bool
}

############################################################
# Enhanced Scanning Configuration
############################################################

variable "enhanced_scanning_scan_type" {
  description = "ECR registry scanning type."
  type        = string
}

variable "enhanced_scanning_filter_type" {
  description = "ECR repository filter type used for enhanced scanning."
  type        = string
}

############################################################
# Common Tags
############################################################

variable "tags" {
  description = "Common tags applied to ECR resources."
  type        = map(string)
}


variable "kms_encryption_enabled" {
  description = "Whether the ECR repository uses a KMS key."
  type        = bool
}
