variable "newrelic_license_key" {
  type = string
}

variable "bucket_prefix" {
  type = string
}

data "aws_caller_identity" "current" {}
