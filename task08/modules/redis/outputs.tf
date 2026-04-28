output "id" {
  value = azurerm_redis_cache.this.id
}

output "hostname" {
  value = azurerm_redis_cache.this.hostname
}

output "ssl_port" {
  value = azurerm_redis_cache.this.ssl_port
}

output "hostname_secret_name" {
  value = azurerm_key_vault_secret.hostname.name
}

output "primary_key_secret_name" {
  value = azurerm_key_vault_secret.primary_key.name
}