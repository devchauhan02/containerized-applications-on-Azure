data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

module "keyvault" {
  source = "./modules/keyvault"

  name                = local.keyvault_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  current_object_id   = data.azurerm_client_config.current.object_id
  sku_name            = var.keyvault_sku
  tags                = local.common_tags
}

module "redis" {
  source = "./modules/redis"

  name                          = local.redis_name
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  capacity                      = var.redis_capacity
  sku_name                      = var.redis_sku
  sku_family                    = var.redis_sku_family
  key_vault_id                  = module.keyvault.id
  redis_hostname_secret_name    = var.redis_hostname
  redis_primary_key_secret_name = var.redis_primary_key
  tags                          = local.common_tags

  depends_on = [module.keyvault]
}

module "acr" {
  source = "./modules/acr"

  name                 = local.acr_name
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  sku                  = var.acr_sku
  image_name           = var.image_name
  image_tag            = var.image_tag
  repository_url       = var.repository_url
  repository_branch    = var.repository_branch
  repository_type      = var.repository_type
  context_path         = var.acr_task_context
  dockerfile_path      = var.acr_task_dockerfile
  context_access_token = var.git_pat
  tags                 = local.common_tags
}

resource "time_sleep" "wait_for_image_build" {
  depends_on = [module.acr]

  create_duration = "180s"
}

module "aks" {
  source = "./modules/aks"

  name                           = local.aks_name
  location                       = azurerm_resource_group.this.location
  resource_group_name            = azurerm_resource_group.this.name
  dns_prefix                     = substr(local.normalized_alnum_prefix, 0, 20)
  kubernetes_version             = var.aks_kubernetes_version
  default_node_pool_name         = var.aks_node_pool_name
  default_node_pool_count        = var.aks_node_pool_count
  default_node_pool_vm_size      = var.aks_node_pool_size
  default_node_pool_os_disk_type = var.aks_node_pool_disk_type
  acr_id                         = module.acr.id
  key_vault_id                   = module.keyvault.id
  tenant_id                      = data.azurerm_client_config.current.tenant_id
  tags                           = local.common_tags

  depends_on = [module.acr, module.keyvault]
}

data "azurerm_key_vault_secret" "redis_hostname" {
  name         = module.redis.hostname_secret_name
  key_vault_id = module.keyvault.id

  depends_on = [module.redis]
}

data "azurerm_key_vault_secret" "redis_primary_key" {
  name         = module.redis.primary_key_secret_name
  key_vault_id = module.keyvault.id

  depends_on = [module.redis]
}

module "aci" {
  source = "./modules/aci"

  name                = local.aci_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = var.aci_sku
  dns_name_label      = local.aci_dns_name_label
  image               = module.acr.image_reference
  registry_server     = module.acr.login_server
  registry_username   = module.acr.admin_username
  registry_password   = module.acr.admin_password
  environment_variables = {
    CREATOR        = "ACI"
    REDIS_PORT     = "6380"
    REDIS_SSL_MODE = "True"
  }
  secure_environment_variables = {
    REDIS_URL = data.azurerm_key_vault_secret.redis_hostname.value
    REDIS_PWD = data.azurerm_key_vault_secret.redis_primary_key.value
  }
  tags = local.common_tags

  depends_on = [time_sleep.wait_for_image_build, module.redis]
}

resource "kubectl_manifest" "secret_provider_class" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.key_vault_secret_identity_client_id
    kv_name                    = module.keyvault.name
    redis_url_secret_name      = module.redis.hostname_secret_name
    redis_password_secret_name = module.redis.primary_key_secret_name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })

  depends_on = [module.aks, module.redis]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.login_server
    app_image_name   = var.image_name
    image_tag        = var.image_tag
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider_class, time_sleep.wait_for_image_build]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service_v1" "app" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.service]
}