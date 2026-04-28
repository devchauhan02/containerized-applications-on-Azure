variable "name" {
  description = "Name of the Azure Kubernetes Service cluster"
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy AKS into"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
  default     = null
}

variable "default_node_pool_name" {
  description = "Name of the default node pool"
  type        = string
}

variable "default_node_pool_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "default_node_pool_vm_size" {
  description = "VM size for the default node pool nodes"
  type        = string
}

variable "default_node_pool_os_disk_type" {
  description = "OS disk type for the default node pool (Managed or Ephemeral)"
  type        = string
}

variable "acr_id" {
  description = "Resource ID of the Azure Container Registry for AcrPull role assignment"
  type        = string
}

variable "key_vault_id" {
  description = "Resource ID of the Key Vault for secrets provider access"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID for Key Vault access policy"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the AKS cluster resources"
  type        = map(string)
  default     = {}
}