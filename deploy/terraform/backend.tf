terraform {
  required_version = ">= 1.3.0"

  backend "azurerm" {
    resource_group_name  = "core-rg"
    storage_account_name = "tfstatestorage13543"
    container_name       = "tfstate"
    key                  = "modus-create-infra.tfstate"
  }
}