terraform {
  required_version = ">= 1.12.2"

  backend "s3" {
    key                  = "sample-component/terraform.tfstate"
    workspace_key_prefix = "sample-component"
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
    git            = "https://github.com/terrateam-test/sample-component"

  }
  session_name = "sample-component@component"

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
