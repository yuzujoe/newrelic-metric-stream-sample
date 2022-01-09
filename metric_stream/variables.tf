variable "newrelic_licence_key" {
  type = string
}

variable "bucket_prefix" {
  type = string
}

data "aws_caller_identity" "current" {}
