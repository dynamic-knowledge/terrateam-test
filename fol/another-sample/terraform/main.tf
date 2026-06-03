terraform {
  required_version = "1.15.5"

  backend "s3" {
    key                  = "another-sample/terraform.tfstate"
    workspace_key_prefix = "another-sample"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.2.0"
    }
  }
}


locals {

  default_tags = {
    config-as-code = "terraform"
    alias          = var.alias
    git            = "https://github.com/terrateam-test/another-sample"
    dummy          = "dummy"

  }
  session_name = "another-sample@component"

  tags = merge(var.tags, local.default_tags)
}

################################################################################
## Resources
################################################################################

provider "aws" {
  region = var.region
  assume_role {
    role_arn     = data.terraform_remote_state.provisioning-roles.outputs.role_arn
    external_id  = one(data.terraform_remote_state.provisioning-roles.outputs.external_id)
    session_name = local.session_name
  }
  default_tags {
    tags = local.tags
  }
}



################################################################################
## Data Sources
################################################################################

# import provisioning role
data "terraform_remote_state" "provisioning-roles" {
  backend   = "s3"
  workspace = var.alias

  config = merge(var.backend, {
    key                  = "provisioning-roles/terraform.tfstate"
    workspace_key_prefix = "provisioning-roles"
  })
}

data "aws_caller_identity" "current" {}

output "current" {
  description = "calling entity"
  value       = data.aws_caller_identity.current
}


variable "backend" {
  description = "terraform remote state config"
  type        = map(any)
}



variable "alias" {
  description = "alias"
  type        = string
}


variable "region" {
  description = "aws region"
  type        = string
  default     = "us-west-2"
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(any)
  default     = {}
}



data "aws_iam_policy_document" "another-sample-dummy-policy" {
  statement {
    actions = [
      "events:PutRule",
      "events:PutTargets"
    ]
    resources = [
      "arn:aws:events:us-east-1:${data.aws_caller_identity.current.account_id}:rule/abc",
    ]
  }
}

resource "aws_iam_policy" "another-sample-dummy-policy" {
  name = "another-sample-dummy-policy"
  policy = data.aws_iam_policy_document.another-sample-dummy-policy.json
}
