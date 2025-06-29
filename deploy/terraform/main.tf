provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.prefix
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  sku                 = "Basic"
  admin_enabled       = true
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_web_app" "app" {
  name                = var.webapp_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/flask-app:latest"
  }

  identity {
    type = "SystemAssigned"
  }
}
