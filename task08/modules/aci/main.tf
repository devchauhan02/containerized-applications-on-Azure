resource "azurerm_container_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = var.dns_name_label
  os_type             = "Linux"
  sku                 = var.sku
  tags                = var.tags

  image_registry_credential {
    server   = var.registry_server
    username = var.registry_username
    password = var.registry_password
  }

  container {
    name   = "redis-flask-app"
    image  = var.image
    cpu    = 1
    memory = 1.5

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables        = var.environment_variables
    secure_environment_variables = var.secure_environment_variables
  }
}