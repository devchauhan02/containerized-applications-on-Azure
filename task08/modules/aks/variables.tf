variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "default_node_pool_name" {
  type = string
}

variable "default_node_pool_count" {
  type = number
}

variable "default_node_pool_vm_size" {
  type = string
}

variable "default_node_pool_os_disk_type" {
  type = string
}

variable "acr_id" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}