
resource "azurerm_resource_group" "rg" {
  provider = azurerm.infra

  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  provider = azurerm.infra

  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_app_service_plan" "plan" {
  provider = azurerm.infra

  name                = "${var.prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
  kind = "Linux"
}

resource "azurerm_linux_web_app" "app" {
  provider = azurerm.infra
  
  name                = var.webapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/flask-app:latest"
  }

  app_settings = {
    WEBSITES_PORT = "8000"
    CUSTOM_MESSAGE = "Hello from Terraform"
    DEPLOY_ENV = "terraform"
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.acr.admin_password
  }
}
