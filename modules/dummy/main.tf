
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "xyz" {
  statement {
    actions = [
      "events:PutRule",
      "events:PutTargets",
      "events:DeleteRule",
    ]
    resources = [
      "arn:aws:events:us-east-1:${data.aws_caller_identity.current.account_id}:rule/xyz",
    ]
  }
}

module "nested" {
  source = "../nested-dummy"
  name = var.policy_name
}

variable "policy_name" {
  type = string
  description = "The name of the policy"
}