variable "name_prefix" {
  type        = string
  description = "Prefix used for IAM resource names."

  validation {
    condition     = length(trimspace(var.name_prefix)) > 0
    error_message = "name_prefix cannot be empty."
  }
}

variable "create_role" {
  type        = bool
  description = "Whether to create the IAM role."
  default     = true
}

variable "role_name" {
  type        = string
  description = "Optional explicit IAM role name."
  default     = null
  nullable    = true
}

variable "role_description" {
  type        = string
  description = "Description for the IAM role."
  default     = "IAM role managed by Terraform"
}

variable "role_path" {
  type        = string
  description = "IAM role path."
  default     = "/"
}

variable "max_session_duration" {
  type        = number
  description = "Maximum role session duration in seconds."
  default     = 3600

  validation {
    condition = (
      var.max_session_duration >= 3600 &&
      var.max_session_duration <= 43200
    )
    error_message = "max_session_duration must be between 3600 and 43200."
  }
}

variable "permissions_boundary_arn" {
  type        = string
  description = "Optional permissions boundary ARN."
  default     = null
  nullable    = true
}

variable "trusted_service_principals" {
  type        = list(string)
  description = "AWS services allowed to assume the role."
  default     = []
}

variable "trusted_aws_principal_arns" {
  type        = list(string)
  description = "AWS principal ARNs allowed to assume the role."
  default     = []
}

variable "managed_policy_arns" {
  type        = set(string)
  description = "Existing managed policy ARNs attached to the role."
  default     = []
}

variable "create_oidc_provider" {
  type        = bool
  description = "Whether to create an IAM OIDC provider."
  default     = false
}

variable "oidc_provider_url" {
  type        = string
  description = "OIDC identity provider URL."
  default     = null
  nullable    = true
}

variable "oidc_client_id_list" {
  type        = list(string)
  description = "OIDC audiences or client IDs."
  default     = ["sts.amazonaws.com"]
}

variable "oidc_thumbprint_list" {
  type        = list(string)
  description = "OIDC provider certificate thumbprints."
  default     = []
}

variable "oidc_subjects" {
  type        = list(string)
  description = "Allowed OIDC subject claims."
  default     = []
}

variable "oidc_audiences" {
  type        = list(string)
  description = "Allowed OIDC audience claims."
  default     = ["sts.amazonaws.com"]
}

variable "create_s3_policy" {
  type        = bool
  description = "Whether to create the separate S3 policy."
  default     = false
}

variable "s3_bucket_arns" {
  type        = list(string)
  description = "S3 bucket ARNs allowed by the policy."
  default     = []
}

variable "s3_object_arns" {
  type        = list(string)
  description = "S3 object ARNs allowed by the policy."
  default     = []
}

variable "s3_bucket_actions" {
  type        = list(string)
  description = "Bucket-level S3 actions."
  default = [
    "s3:GetBucketLocation",
    "s3:ListBucket"
  ]
}

variable "s3_object_actions" {
  type        = list(string)
  description = "Object-level S3 actions."
  default = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject"
  ]
}

variable "create_kms_policy" {
  type        = bool
  description = "Whether to create the separate KMS policy."
  default     = false
}

variable "kms_key_arns" {
  type        = list(string)
  description = "KMS key ARNs allowed by the policy."
  default     = []
}

variable "kms_actions" {
  type        = list(string)
  description = "KMS actions allowed by the policy."
  default = [
    "kms:Encrypt",
    "kms:Decrypt",
    "kms:ReEncrypt*",
    "kms:GenerateDataKey*",
    "kms:DescribeKey"
  ]
}

variable "create_secrets_manager_policy" {
  type        = bool
  description = "Whether to create the Secrets Manager policy."
  default     = false
}

variable "secret_arns" {
  type        = list(string)
  description = "Secrets Manager secret ARNs allowed by the policy."
  default     = []
}

variable "secrets_manager_actions" {
  type        = list(string)
  description = "Secrets Manager actions allowed by the policy."
  default = [
    "secretsmanager:GetSecretValue",
    "secretsmanager:DescribeSecret",
    "secretsmanager:ListSecretVersionIds"
  ]
}

variable "create_vpc_policy" {
  type        = bool
  description = "Whether to create the separate VPC policy."
  default     = false
}

variable "vpc_policy_resources" {
  type        = list(string)
  description = "Resources allowed by the VPC policy."
  default     = ["*"]
}

variable "vpc_policy_actions" {
  type        = list(string)
  description = "EC2 and VPC actions allowed by the policy."
  default = [
    "ec2:Describe*",
    "ec2:CreateVpc",
    "ec2:DeleteVpc",
    "ec2:ModifyVpcAttribute",
    "ec2:CreateSubnet",
    "ec2:DeleteSubnet",
    "ec2:ModifySubnetAttribute",
    "ec2:CreateInternetGateway",
    "ec2:DeleteInternetGateway",
    "ec2:AttachInternetGateway",
    "ec2:DetachInternetGateway",
    "ec2:AllocateAddress",
    "ec2:ReleaseAddress",
    "ec2:CreateNatGateway",
    "ec2:DeleteNatGateway",
    "ec2:CreateRouteTable",
    "ec2:DeleteRouteTable",
    "ec2:AssociateRouteTable",
    "ec2:DisassociateRouteTable",
    "ec2:CreateRoute",
    "ec2:ReplaceRoute",
    "ec2:DeleteRoute",
    "ec2:CreateVpcEndpoint",
    "ec2:ModifyVpcEndpoint",
    "ec2:DeleteVpcEndpoints",
    "ec2:CreateTags",
    "ec2:DeleteTags"
  ]
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for IAM resources."
  default     = {}
}
