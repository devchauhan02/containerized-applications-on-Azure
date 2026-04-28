output "id" {
  value = azurerm_container_registry.this.id
}

output "login_server" {
  value = azurerm_container_registry.this.login_server
}

output "admin_username" {
  value = azurerm_container_registry.this.admin_username
}

output "admin_password" {
  value     = azurerm_container_registry.this.admin_password
  sensitive = true
}

output "image_reference" {
  value = "${azurerm_container_registry.this.login_server}/${var.image_name}:${var.image_tag}"
}

output "build_trigger_id" {
  value = azurerm_container_registry_task_schedule_run_now.this.id
}