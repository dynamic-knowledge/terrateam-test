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

variable "legacy_env" {
  description = "Identifier for connecting this workspace to related workspaces in other components (e.g. dev3)"
  type        = string
}

variable "tenant" {
  description = "tenant"
  type        = string
  default     = "default"
}

variable "akp_org_name" {
  description = "The organization name in the Akuity Platform"
  type        = string
  default     = "semgrep"
}

variable "akp_kargo_instance_name" {
  description = "Name of the Kargo instance on the Akuity Platform that should serve as the control plane for this cluster"
  type        = string
  default     = "default"
}

variable "akp_argocd_instance_name" {
  description = "Name of the ArgoCD instance on the Akuity Platform that should serve as the control plane for this cluster"
  type        = string
  default     = "default"
}

variable "kargo_agent_size" {
  description = "Size of the Akuity Kargo agent: https://docs.akuity.io/argocd/managing-instances/clusters/agent-advanced-settings#agent-size"
  type        = string
  default     = "large"
}

variable "kargo_agent_version" {
  description = "Version of the Kargo agent"
  type        = string
  default     = "0.5.88"
}

variable "is_default_shard_agent" {
  description = "Whether to set this agent as the default shard agent (only one agent per instance can be the default)"
  type        = bool
  default     = false
}

variable "kargo_allowed_ecr_repos" {
  description = "ECR repo names that Kargo will have access to (may contain wildcards). Only valid for the default shard agent."
  type        = list(string)
  default     = []
}

variable "argocd_url" {
  description = "URL of ArgoCD UI associated with this agent"
  type        = string
}

variable "enable_argocd_agent" {
  description = "Whether to create an ArgoCD agent in the target cluster"
  type        = bool
  default     = false
}

variable "argocd_agent_size" {
  description = "Size of the Akuity ArgoCD agent: https://docs.akuity.io/argocd/managing-instances/clusters/agent-advanced-settings#agent-size"
  type        = string
  default     = "small"
}

variable "argocd_allowed_ecr_repos" {
  description = "ECR repo names that ArgoCD will have access to (may contain wildcards). Only valid for the default shard agent."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(any)
  default     = {}
}

variable "datadog_api_key" {
  description = "API key for Datadog. Set via $TF_VAR_datadog_api_key environment variable"
  type        = string
  sensitive   = true
  default     = ""
}

variable "datadog_app_key" {
  description = "APP key for Datadog. Set via $TF_VAR_datadog_app_key environment variable"
  type        = string
  sensitive   = true
  default     = ""
}

variable "create_datadog_kargo_creds" {
  description = "Whether to create the {env}-kargo-datadog-creds AWS Secrets Manager secret and its two Datadog keys (used by Kargo verification for metrics and synthetics)."
  type        = bool
  default     = false
}
