variable "resource_group_name" {
  type = string
}

variable "infra_subscription_id" {
  type        = string
  description = "Subscription ID for infrastructure deployment"
}

variable "infra_client_id" {
  type        = string
  description = "Client ID for the infra SP"
}

variable "infra_client_secret" {
  type        = string
  description = "Client Secret for the infra SP"
  sensitive   = true
}

variable "infra_tenant_id" {
  type        = string
  description = "Tenant ID for the infra SP"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "prefix" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "webapp_name" {
  type = string
}
