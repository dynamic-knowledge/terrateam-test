
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

resource "aws_iam_policy" "nested_dummy" {
  name = var.name
  policy = data.aws_iam_policy_document.xyz.json
}

variable "name" {
  type = string
  description = "The name of the policy"
}