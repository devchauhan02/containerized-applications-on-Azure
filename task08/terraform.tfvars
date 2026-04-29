
location    = "eastus"
name_prefix = "cmtr-49e4rswo-mod8"

student_email = "devashish_chauhan@epam.com"

repository_url    = "https://github.com/devchauhan02/containerized-applications-on-Azure"
repository_branch = "main"
repository_type   = "Github"

acr_task_context    = "task08/application"
acr_task_dockerfile = "Dockerfile"
image_name          = "cmtr-49e4rswo-mod8-app"
image_tag           = "latest"


acr_sku = "Basic"


aci_sku = "Standard"

redis_capacity   = 2
redis_sku        = "Basic"
redis_sku_family = "C"

keyvault_sku = "standard"


redis_primary_key = "redis-primary-key"
redis_hostname    = "redis-hostname"

aks_node_pool_name      = "system"
aks_node_pool_count     = 1
aks_node_pool_size      = "Standard_D2ads_v6"
aks_node_pool_disk_type = "Ephemeral"

