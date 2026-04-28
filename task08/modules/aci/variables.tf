variable "name" {
  description = "Name of the Azure Container Instance"
  type        = string
}

variable "location" {
  description = "Azure region for the Container Instance"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy Container Instance into"
  type        = string
}

variable "sku" {
  description = "SKU for the Container Instance (Standard or Dedicated)"
  type        = string
}

variable "dns_name_label" {
  description = "DNS name label for the Container Instance public IP"
  type        = string
}

variable "image" {
  description = "Full container image name including registry and tag"
  type        = string
}

variable "registry_server" {
  description = "Container registry server URL"
  type        = string
}

variable "registry_username" {
  description = "Username for container registry authentication"
  type        = string
}

variable "registry_password" {
  description = "Password for container registry authentication"
  type        = string
  sensitive   = true
}

variable "environment_variables" {
  description = "Environment variables to set in the container"
  type        = map(string)
  default     = {}
}

variable "secure_environment_variables" {
  description = "Secure environment variables to set in the container"
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the Container Instance resource"
  type        = map(string)
  default     = {}
}