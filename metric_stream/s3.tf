resource "aws_s3_bucket" "firehose_event" {
  bucket = "${var.bucket_prefix}-firehose-event"
  acl    = "private"
}

resource "aws_s3_bucket" "config" {
  bucket = "${var.bucket_prefix}-metric-stream-config"
  acl    = "private"
}
