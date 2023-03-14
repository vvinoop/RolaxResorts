resource "azurerm_resource_group" "app_rg" {
  location = var.app_location
  name     = var.app_rg_name
}

resource "azurerm_container_app_environment" "app_env" {
  location                       = var.app_location
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.log_workspace.id
  name                           = var.app_env_name
  resource_group_name            = azurerm_resource_group.app_rg.name
  internal_load_balancer_enabled = false
  infrastructure_subnet_id       = azurerm_subnet.container_subnet.id

  timeouts {
    create = "2h"
    delete = "2h"
    update = "2h"
    read   = "30m"
  }
}

resource "azurerm_container_app_environment_certificate" "appenv_cert" {
  certificate_blob_base64      = filebase64(var.app_env_cert_path)
  certificate_password         = var.app_env_cert_pass
  container_app_environment_id = azurerm_container_app_environment.app_env.id
  name                         = var.app_env_cert_name
}

resource "azurerm_container_app" "app" {
  container_app_environment_id = azurerm_container_app_environment.app_env.id
  name                         = var.app_name
  resource_group_name          = azurerm_resource_group.app_rg.name
  revision_mode                = "Single"
  template {
    min_replicas = 3
    max_replicas = 5
    container {
      name   = var.app_name
      cpu    = 0.25
      image  = var.app_image
      memory = "0.5Gi"
    }
  }
  ingress {
    target_port      = 80
    external_enabled = true
    traffic_weight {
      percentage = 100
    }

    custom_domain {
      name           = var.app_custome_domain_name
      certificate_id = azurerm_container_app_environment_certificate.appenv_cert.id
    }
  }
  identity {
    type = "SystemAssigned"
  }

  timeouts {
    create = "2h"
    delete = "2h"
    update = "2h"
    read   = "30m"
  }
}

resource "azurerm_role_assignment" "acr_pull_role" {
  principal_id         = azurerm_container_app.app.identity[0].principal_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
}
