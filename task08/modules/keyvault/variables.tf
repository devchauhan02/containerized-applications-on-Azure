variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "current_object_id" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}