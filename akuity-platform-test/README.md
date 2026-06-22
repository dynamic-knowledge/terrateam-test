<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_akp"></a> [akp](#requirement\_akp) | 0.10.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.40.0 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | 4.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_akp"></a> [akp](#provider\_akp) | 0.10.2 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.40.0 |
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | 4.4.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argocd-ecr-service-account"></a> [argocd-ecr-service-account](#module\_argocd-ecr-service-account) | ../../../modules/service-account | n/a |
| <a name="module_ecr-service-account"></a> [ecr-service-account](#module\_ecr-service-account) | ../../../modules/service-account | n/a |
| <a name="module_kargo-agent"></a> [kargo-agent](#module\_kargo-agent) | ../../../modules/akuity-kargo-agent | n/a |

## Resources

| Name | Type |
|------|------|
| [akp_cluster.this](https://registry.terraform.io/providers/akuity/akp/0.10.2/docs/resources/cluster) | resource |
| [aws_secretsmanager_secret.datadog_kargo_creds](https://registry.terraform.io/providers/hashicorp/aws/6.40.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.datadog_kargo_creds](https://registry.terraform.io/providers/hashicorp/aws/6.40.0/docs/resources/secretsmanager_secret_version) | resource |
| [datadog_api_key.kargo](https://registry.terraform.io/providers/DataDog/datadog/4.4.0/docs/resources/api_key) | resource |
| [datadog_application_key.kargo](https://registry.terraform.io/providers/DataDog/datadog/4.4.0/docs/resources/application_key) | resource |
| [akp_instance.control-plane](https://registry.terraform.io/providers/akuity/akp/0.10.2/docs/data-sources/instance) | data source |
| [akp_kargo_instance.control-plane](https://registry.terraform.io/providers/akuity/akp/0.10.2/docs/data-sources/kargo_instance) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/6.40.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.argocd-ecr](https://registry.terraform.io/providers/hashicorp/aws/6.40.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr](https://registry.terraform.io/providers/hashicorp/aws/6.40.0/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/6.40.0/docs/data-sources/region) | data source |
| [terraform_remote_state.core-platform](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.provisioning-roles](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_akp_argocd_instance_name"></a> [akp\_argocd\_instance\_name](#input\_akp\_argocd\_instance\_name) | Name of the ArgoCD instance on the Akuity Platform that should serve as the control plane for this cluster | `string` | `"default"` | no |
| <a name="input_akp_kargo_instance_name"></a> [akp\_kargo\_instance\_name](#input\_akp\_kargo\_instance\_name) | Name of the Kargo instance on the Akuity Platform that should serve as the control plane for this cluster | `string` | `"default"` | no |
| <a name="input_akp_org_name"></a> [akp\_org\_name](#input\_akp\_org\_name) | The organization name in the Akuity Platform | `string` | `"semgrep"` | no |
| <a name="input_alias"></a> [alias](#input\_alias) | alias | `string` | n/a | yes |
| <a name="input_argocd_agent_size"></a> [argocd\_agent\_size](#input\_argocd\_agent\_size) | Size of the Akuity ArgoCD agent: https://docs.akuity.io/argocd/managing-instances/clusters/agent-advanced-settings#agent-size | `string` | `"small"` | no |
| <a name="input_argocd_allowed_ecr_repos"></a> [argocd\_allowed\_ecr\_repos](#input\_argocd\_allowed\_ecr\_repos) | ECR repo names that ArgoCD will have access to (may contain wildcards). Only valid for the default shard agent. | `list(string)` | `[]` | no |
| <a name="input_argocd_url"></a> [argocd\_url](#input\_argocd\_url) | URL of ArgoCD UI associated with this agent | `string` | n/a | yes |
| <a name="input_backend"></a> [backend](#input\_backend) | terraform remote state config | `map(any)` | n/a | yes |
| <a name="input_create_datadog_kargo_creds"></a> [create\_datadog\_kargo\_creds](#input\_create\_datadog\_kargo\_creds) | Whether to create the {env}-kargo-datadog-creds AWS Secrets Manager secret and its two Datadog keys (used by Kargo verification for metrics and synthetics). | `bool` | `false` | no |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | API key for Datadog. Set via $TF\_VAR\_datadog\_api\_key environment variable | `string` | `""` | no |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | APP key for Datadog. Set via $TF\_VAR\_datadog\_app\_key environment variable | `string` | `""` | no |
| <a name="input_enable_argocd_agent"></a> [enable\_argocd\_agent](#input\_enable\_argocd\_agent) | Whether to create an ArgoCD agent in the target cluster | `bool` | `false` | no |
| <a name="input_is_default_shard_agent"></a> [is\_default\_shard\_agent](#input\_is\_default\_shard\_agent) | Whether to set this agent as the default shard agent (only one agent per instance can be the default) | `bool` | `false` | no |
| <a name="input_kargo_agent_size"></a> [kargo\_agent\_size](#input\_kargo\_agent\_size) | Size of the Akuity Kargo agent: https://docs.akuity.io/argocd/managing-instances/clusters/agent-advanced-settings#agent-size | `string` | `"large"` | no |
| <a name="input_kargo_agent_version"></a> [kargo\_agent\_version](#input\_kargo\_agent\_version) | Version of the Kargo agent | `string` | `"0.5.88"` | no |
| <a name="input_kargo_allowed_ecr_repos"></a> [kargo\_allowed\_ecr\_repos](#input\_kargo\_allowed\_ecr\_repos) | ECR repo names that Kargo will have access to (may contain wildcards). Only valid for the default shard agent. | `list(string)` | `[]` | no |
| <a name="input_legacy_env"></a> [legacy\_env](#input\_legacy\_env) | Identifier for connecting this workspace to related workspaces in other components (e.g. dev3) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | aws region | `string` | `"us-west-2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(any)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | tenant | `string` | `"default"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->