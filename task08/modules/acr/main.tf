locals {
  task_name = substr("${var.name}task", 0, 50)
}

resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_container_registry_task" "this" {
  name                  = local.task_name
  container_registry_id = azurerm_container_registry.this.id
  tags                  = var.tags

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = var.dockerfile_path
    context_path         = "${var.repository_url}#${var.repository_branch}:${trim(var.context_path, "/")}"
    context_access_token = var.context_access_token
    image_names          = ["${var.image_name}:${var.image_tag}"]
    push_enabled         = true
  }

  registry_credential {
    source {
      login_mode = "Default"
    }
  }

  source_trigger {
    name           = "commit-trigger"
    events         = ["commit"]
    repository_url = var.repository_url
    source_type    = var.repository_type
    branch         = var.repository_branch

    authentication {
      token      = var.context_access_token
      token_type = "PAT"
    }
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "this" {
  container_registry_task_id = azurerm_container_registry_task.this.id
}