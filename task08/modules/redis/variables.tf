variable "name" {
  description = "Name of the Azure Redis Cache instance"
  type        = string
}

variable "location" {
  description = "Azure region for the Redis Cache"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy Redis Cache into"
  type        = string
}

variable "capacity" {
  description = "Size of the Redis Cache to deploy"
  type        = number
}

variable "sku_name" {
  description = "SKU name for the Redis Cache (Basic, Standard, Premium)"
  type        = string
}

variable "sku_family" {
  description = "SKU family for the Redis Cache (C for Basic/Standard, P for Premium)"
  type        = string
}

variable "key_vault_id" {
  description = "Resource ID of the Key Vault to store Redis secrets"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Name of the Key Vault secret to store the Redis hostname"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Name of the Key Vault secret to store the Redis primary access key"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Redis Cache resource"
  type        = map(string)
  default     = {}
}