variable "name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region for the Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy Key Vault into"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID for the Key Vault"
  type        = string
}

variable "current_object_id" {
  description = "Object ID of the current user for initial Key Vault access policy"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the Key Vault (standard or premium)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Key Vault resource"
  type        = map(string)
  default     = {}
}