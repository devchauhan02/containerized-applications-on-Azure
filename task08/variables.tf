variable "location" {
  description = "Azure region for all task08 resources."
  type        = string
  default     = "eastus"
}

variable "name_prefix" {
  description = "Prefix used to derive rg_name, aci_name, acr_name, aks_name, keyvault_name, and redis_name."
  type        = string
}

variable "student_email" {
  description = "Value used for the Creator tag on tagged resources."
  type        = string
}

variable "git_pat" {
  description = "Personal access token used by the ACR task to pull the source context from the git repository."
  type        = string
  sensitive   = true
}

variable "repository_url" {
  description = "HTTPS repository URL used as the ACR Task build source."
  type        = string
}

variable "repository_branch" {
  description = "Repository branch used for the ACR Task build source."
  type        = string
  default     = "main"
}

variable "repository_type" {
  description = "Source control system used by the repository_url."
  type        = string
  default     = "Github"
}

variable "acr_task_context" {
  description = "Repository subdirectory that contains the application build context."
  type        = string
  default     = "task08/application"
}

variable "acr_task_dockerfile" {
  description = "Dockerfile path relative to the ACR Task context directory."
  type        = string
  default     = "Dockerfile"
}

variable "image_name" {
  description = "Docker image name to push into Azure Container Registry."
  type        = string
}

variable "image_tag" {
  description = "Docker image tag produced by the ACR Task and used by ACI and AKS."
  type        = string
  default     = "latest"
}

variable "redis_capacity" {
  description = "Azure Redis Cache capacity."
  type        = number
}

variable "redis_sku" {
  description = "Azure Redis Cache SKU."
  type        = string
}

variable "redis_sku_family" {
  description = "Azure Redis Cache SKU family."
  type        = string
}

variable "keyvault_sku" {
  description = "Azure Key Vault SKU."
  type        = string
}

variable "redis_primary_key" {
  description = "Secret name used to store the Redis primary key in Key Vault."
  type        = string
}

variable "redis_hostname" {
  description = "Secret name used to store the Redis hostname in Key Vault."
  type        = string
}

variable "acr_sku" {
  description = "Azure Container Registry SKU."
  type        = string
}

variable "aci_sku" {
  description = "Azure Container Instance SKU."
  type        = string
}

variable "aks_node_pool_name" {
  description = "AKS default node pool name."
  type        = string
}

variable "aks_node_pool_count" {
  description = "AKS default node pool instance count."
  type        = number
}

variable "aks_node_pool_size" {
  description = "AKS default node pool VM size."
  type        = string
}

variable "aks_node_pool_disk_type" {
  description = "AKS default node pool OS disk type."
  type        = string
}

variable "aks_kubernetes_version" {
  description = "Optional AKS Kubernetes version. If null, Azure selects the recommended version."
  type        = string
  default     = null
}