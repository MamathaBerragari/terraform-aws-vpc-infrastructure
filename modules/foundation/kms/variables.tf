variable "alias_name" {
  type        = string
  description = "KMS alias. The alias prefix is added automatically."

  validation {
    condition     = length(trimspace(var.alias_name)) > 0
    error_message = "alias_name cannot be empty."
  }
}

variable "description" {
  type        = string
  description = "KMS key description."
  default     = "KMS key managed by Terraform"
}

variable "deletion_window_in_days" {
  type        = number
  description = "Waiting period before permanent key deletion."
  default     = 30

  validation {
    condition = (
      var.deletion_window_in_days >= 7 &&
      var.deletion_window_in_days <= 30
    )
    error_message = "deletion_window_in_days must be between 7 and 30."
  }
}

variable "enable_key_rotation" {
  type        = bool
  description = "Whether automatic key rotation is enabled."
  default     = true
}

variable "is_enabled" {
  type        = bool
  description = "Whether the KMS key is enabled."
  default     = true
}

variable "multi_region" {
  type        = bool
  description = "Whether the key is a multi-Region primary key."
  default     = false
}

variable "key_usage" {
  type        = string
  description = "Intended use of the KMS key."
  default     = "ENCRYPT_DECRYPT"
}

variable "customer_master_key_spec" {
  type        = string
  description = "KMS key material specification."
  default     = "SYMMETRIC_DEFAULT"
}

variable "bypass_policy_lockout_safety_check" {
  type        = bool
  description = "Whether to bypass the KMS lockout safety check."
  default     = false
}

variable "key_administrator_arns" {
  type        = list(string)
  description = "IAM principal ARNs allowed to administer the key."
  default     = []
}

variable "key_user_arns" {
  type        = list(string)
  description = "IAM principal ARNs allowed to use the key."
  default     = []
}

variable "service_principals" {
  type        = list(string)
  description = "AWS services allowed to create grants."
  default     = []
}

variable "policy_json" {
  type        = string
  description = "Optional complete custom KMS policy JSON."
  default     = null
  nullable    = true
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for the KMS key."
  default     = {}
}
