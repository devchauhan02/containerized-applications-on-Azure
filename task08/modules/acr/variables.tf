variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku" {
  type = string
}

variable "image_name" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "repository_url" {
  type = string
}

variable "repository_branch" {
  type = string
}

variable "repository_type" {
  type = string
}

variable "context_path" {
  type = string
}

variable "dockerfile_path" {
  type = string
}

variable "context_access_token" {
  type      = string
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}