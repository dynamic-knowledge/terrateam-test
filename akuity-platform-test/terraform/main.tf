################################################################################
## Configuration
################################################################################

terraform {
  required_version = ">= 1.12.2"

  backend "s3" {
    key                  = "akuity-platform-test/terraform.tfstate"
    workspace_key_prefix = "akuity-platform-test"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
    akp = {
      source  = "akuity/akp"
      version = "0.10.2"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = "4.4.0"
    }
  }
}

################################################################################
## References
################################################################################

locals {
  default_tags = {
    config-as-code = "terraform"
    alias          = var.alias


  }
  session_name = "akuity-platform-test@component"

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

provider "akp" {
  org_name = var.akp_org_name
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
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
data "aws_region" "current" {}

data "terraform_remote_state" "core-platform" {
  backend   = "s3"
  workspace = "${var.alias}-${var.tenant}-${var.legacy_env}"

  config = merge(var.backend, {
    key                  = "core-platform/terraform.tfstate"
    workspace_key_prefix = "core-platform"
  })
}

data "akp_kargo_instance" "control-plane" {
  name = var.akp_kargo_instance_name
}

data "akp_instance" "control-plane" {
  name = var.akp_argocd_instance_name
}
data "datadog_users" "test" {
  filter        = "lina@semgrep.dev"
}

################################################################################
## Resources
################################################################################
