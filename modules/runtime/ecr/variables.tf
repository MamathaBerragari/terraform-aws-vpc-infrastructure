variable "repository_name" {

  description = "Name of the ECR repository."

  type = string

}

variable "image_tag_mutability" {

  description = "Whether image tags are mutable."

  type = string

  default = "IMMUTABLE"

  validation {

    condition = contains(
      ["MUTABLE", "IMMUTABLE"],
      var.image_tag_mutability
    )

    error_message = "Must be MUTABLE or IMMUTABLE."

  }

}

variable "scan_on_push" {

  description = "Enable image scan on push."

  type = bool

  default = true

}

variable "kms_key_arn" {

  description = "Existing KMS Key ARN."

  type = string

}

variable "lifecycle_max_image_count" {

  description = "Maximum images to retain."

  type = number

  default = 20

}

variable "repository_read_principals" {

  description = "IAM principals allowed read access."

  type = list(string)

  default = []

}

variable "repository_write_principals" {

  description = "IAM principals allowed push access."

  type = list(string)

  default = []

}

variable "tags" {

  description = "Common resource tags."

  type = map(string)

  default = {}

}
