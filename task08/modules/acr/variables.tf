variable "name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "location" {
  description = "Azure region for the Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy Container Registry into"
  type        = string
}

variable "sku" {
  description = "SKU for the Container Registry (Basic, Standard, or Premium)"
  type        = string
}

variable "image_name" {
  description = "Name of the Docker image to build"
  type        = string
}

variable "image_tag" {
  description = "Tag for the Docker image"
  type        = string
}

variable "repository_url" {
  description = "Git repository URL for the ACR Task source"
  type        = string
}

variable "repository_branch" {
  description = "Git branch for the ACR Task source"
  type        = string
}

variable "repository_type" {
  description = "Type of the source repository (Github, DevOps)"
  type        = string
}

variable "context_path" {
  description = "Path within the repository for the build context"
  type        = string
}

variable "dockerfile_path" {
  description = "Path to the Dockerfile relative to the context"
  type        = string
}

variable "context_access_token" {
  description = "Personal access token for authenticating to the git repository"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the Container Registry resources"
  type        = map(string)
  default     = {}
}