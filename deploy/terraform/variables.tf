variable "resource_group_name" {
  type = string
}

variable "infra_subscription_id" {
  type = string
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
