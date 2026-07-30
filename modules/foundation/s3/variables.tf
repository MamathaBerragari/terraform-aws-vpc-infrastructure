variable "bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name."

  validation {
    condition = (
      length(var.bucket_name) >= 3 &&
      length(var.bucket_name) <= 63
    )
    error_message = "bucket_name must contain between 3 and 63 characters."
  }
}

variable "force_destroy" {
  type        = bool
  description = "Whether Terraform may delete a non-empty bucket."
  default     = false
}

variable "object_ownership" {
  type        = string
  description = "S3 object ownership configuration."
  default     = "BucketOwnerEnforced"

  validation {
    condition = contains(
      [
        "BucketOwnerEnforced",
        "BucketOwnerPreferred",
        "ObjectWriter"
      ],
      var.object_ownership
    )
    error_message = "Unsupported object_ownership value."
  }
}

variable "block_public_acls" {
  type        = bool
  description = "Whether public ACLs are blocked."
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "Whether public bucket policies are blocked."
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether public ACLs are ignored."
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether public buckets are restricted."
  default     = true
}

variable "versioning_enabled" {
  type        = bool
  description = "Whether S3 versioning is enabled."
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "Optional KMS key ARN for SSE-KMS encryption."
  default     = null
  nullable    = true
}

variable "bucket_key_enabled" {
  type        = bool
  description = "Whether the S3 Bucket Key feature is enabled."
  default     = true
}

variable "enforce_tls" {
  type        = bool
  description = "Whether requests without TLS are denied."
  default     = true
}

variable "allowed_principal_arns" {
  type        = list(string)
  description = "AWS principal ARNs allowed through the bucket policy."
  default     = []
}

variable "allowed_principal_actions" {
  type        = list(string)
  description = "S3 actions granted to allowed principals."
  default = [
    "s3:GetBucketLocation",
    "s3:ListBucket",
    "s3:GetObject",
    "s3:PutObject"
  ]
}

variable "allowed_principal_resources" {
  type        = list(string)
  description = "Optional explicit resources for principal access."
  default     = []
}

variable "additional_policy_json" {
  type        = string
  description = "Optional additional S3 bucket policy JSON."
  default     = null
  nullable    = true
}

variable "lifecycle_rules" {
  description = "S3 lifecycle rules."

  type = list(object({
    id                                     = string
    enabled                                = optional(bool, true)
    prefix                                 = optional(string, "")
    expiration_days                        = optional(number)
    noncurrent_version_expiration_days     = optional(number)
    abort_incomplete_multipart_upload_days = optional(number)
  }))

  default = []
}

variable "tags" {
  type        = map(string)
  description = "Additional S3 bucket tags."
  default     = {}
}
