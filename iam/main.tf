resource "aws_iam_role" "newrelic_integrations" {
  name               = "NewRelicInfrastructure-Integrations"
  assume_role_policy = data.aws_iam_policy_document.newrelic_integrations.json
}

data "aws_iam_policy_document" "newrelic_integrations" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    condition {
      test = "StringEquals"
      // NewRelic AccountID
      values   = [var.newrelic_account_id]
      variable = "sts:ExternalID"
    }

    principals {
      identifiers = [var.another_aws_account_id]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role_policy_attachment" "read_only_access" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.newrelic_integrations.id
}
