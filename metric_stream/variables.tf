variable "newrelic_licence_key" {
  type = string
}

variable "bucket_prefix" {
  type = string
  default = ""
}

data "aws_caller_identity" "current" {}
