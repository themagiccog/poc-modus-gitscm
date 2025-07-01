
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

resource "azurerm_service_plan" "plan" {
  provider            = azurerm.infra
  name                = "${var.prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type   = "Linux"      # replaces 'kind' and 'reserved'
  sku_name  = "F1"         # replaces sku { tier, size }
}

resource "azurerm_linux_web_app" "app" {
  provider = azurerm.infra

  depends_on = [azurerm_container_registry.acr]
  
  name                = var.webapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    container_registry_use_managed_identity = false
    always_on               = false
    linux_fx_version = " DOCKER|${azurerm_container_registry.acr.login_server}/flask-app:latest"
    application_stack {
      docker_image_name     = "${azurerm_container_registry.acr.login_server}/flask-app:latest"
      docker_registry_url   = "https://${azurerm_container_registry.acr.login_server}"
      docker_registry_username = azurerm_container_registry.acr.admin_username
      docker_registry_password = azurerm_container_registry.acr.admin_password
    }
  }

  app_settings = {
    WEBSITES_PORT = "8000"
    CUSTOM_MESSAGE = "Hello from Terraform"
    DEPLOY_ENV = "terraform"
  }
}
