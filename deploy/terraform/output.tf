output "acr_login_server" {
  value = data.azurerm_container_registry.acr.login_server
}

output "webapp_url" {
  value = azurerm_linux_web_app.app.default_hostname
}

output "image_url" {
  value = "${data.azurerm_container_registry.acr.login_server}/flask-app:latest"
}
