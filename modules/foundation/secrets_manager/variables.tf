variable "secret_name" {
  type        = string
  description = "Name of the Secrets Manager secret."

  validation {
    condition     = length(trimspace(var.secret_name)) > 0
    error_message = "secret_name cannot be empty."
  }
}

variable "description" {
  type        = string
  description = "Description for the secret."
  default     = "Secret managed by Terraform"
}

variable "kms_key_id" {
  type        = string
  description = "Optional KMS key ID or ARN."
  default     = null
  nullable    = true
}

variable "recovery_window_in_days" {
  type        = number
  description = "Recovery window before permanent secret deletion."
  default     = 30

  validation {
    condition = (
      var.recovery_window_in_days == 0 ||
      (
        var.recovery_window_in_days >= 7 &&
        var.recovery_window_in_days <= 30
      )
    )
    error_message = "recovery_window_in_days must be 0 or between 7 and 30."
  }
}

variable "allowed_principal_arns" {
  type        = list(string)
  description = "AWS principals allowed by the resource policy."
  default     = []
}

variable "allowed_principal_actions" {
  type        = list(string)
  description = "Secrets Manager actions granted by the resource policy."
  default = [
    "secretsmanager:GetSecretValue",
    "secretsmanager:DescribeSecret"
  ]
}

variable "additional_policy_json" {
  type        = string
  description = "Optional additional resource policy JSON."
  default     = null
  nullable    = true
}

variable "block_public_policy" {
  type        = bool
  description = "Whether public secret policies are rejected."
  default     = true
}

variable "create_rotation" {
  type        = bool
  description = "Whether automatic secret rotation is configured."
  default     = false
}

variable "rotation_lambda_arn" {
  type        = string
  description = "Lambda ARN used for secret rotation."
  default     = null
  nullable    = true
}

variable "rotation_automatically_after_days" {
  type        = number
  description = "Number of days between secret rotations."
  default     = 30

  validation {
    condition = (
      var.rotation_automatically_after_days >= 1 &&
      var.rotation_automatically_after_days <= 1000
    )
    error_message = "Rotation days must be between 1 and 1000."
  }
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for the secret."
  default     = {}
}
