
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "xyz" {
  statement {
    actions = [
      "events:PutRule",
      "events:PutTargets"
    ]
    resources = [
      "arn:aws:events:us-east-1:${data.aws_caller_identity.current.account_id}:rule/xyz",
    ]
  }
}
