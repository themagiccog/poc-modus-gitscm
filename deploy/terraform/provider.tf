provider "azurerm" {
  alias           = "infra"
  subscription_id = var.infra_subscription_id
  client_id       = var.infra_client_id
  client_secret   = var.infra_client_secret
  tenant_id       = var.infra_tenant_id

  features {}
}

provider "azurerm" {
  alias           = "state"
  # the creds are already in environment variables
  features {}

}