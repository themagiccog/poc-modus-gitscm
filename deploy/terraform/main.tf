
resource "azurerm_resource_group" "rg" {
  provider = azurerm.infra

  name     = var.resource_group_name
  location = var.location
}

# #if New ACR
# resource "azurerm_container_registry" "acr" {
#   provider = azurerm.infra

#   name                = var.acr_name
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   sku                 = "Basic"
#   admin_enabled       = true
# }

data "azurerm_container_registry" "acr" {
  provider            = azurerm.state
  name                = "az4africa"
  resource_group_name = "core-rg"

}

# Get User Managed Identity
data "azurerm_user_assigned_identity" "identity" {
  provider            = azurerm.state
  name                = "core-resources-umi"
  resource_group_name = "core-rg"
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

  depends_on = [data.azurerm_container_registry.acr]
  
  name                = var.webapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  # Specify Managed Identity with its id (Type is UserAssigned)
  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.identity.id]
  }

  site_config {
    # Use the Managed Identity for Authentication to ACR (true), specify Client id of the Managed Identity
    # This is needed to pull the image from ACR without using username and password
    container_registry_use_managed_identity         = true
    container_registry_managed_identity_client_id   = data.azurerm_user_assigned_identity.identity.client_id

    # always on = false, needs to be config'd when using Free tier
    always_on               = false
    
    # the app will fail first time, because there is no image to deploy. But when webapp is deployed, it will be resolved.
    application_stack {
      docker_image_name     = "flask-app:0.0.1"
      docker_registry_url   = "https://${data.azurerm_container_registry.acr.login_server}"
      
      ## Below not needed as we are using Managed Identity
      # docker_registry_username = data.azurerm_container_registry.acr.admin_username
      # docker_registry_password = data.azurerm_container_registry.acr.admin_password
    }
  }


  app_settings = {
    WEBSITES_PORT = "8000"
    CUSTOM_MESSAGE = "Hello from Terraform"
    DEPLOY_ENV = "terraform"
  }
}
