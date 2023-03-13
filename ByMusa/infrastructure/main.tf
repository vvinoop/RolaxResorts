resource "azurerm_resource_group" "app_rg" {
  location = var.app_location
  name     = var.app_rg_name
}

resource "azurerm_container_app_environment" "app_env" {
  location                       = var.app_location
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.log_workspace.id
  name                           = var.app_env_name
  resource_group_name            = azurerm_resource_group.app_rg.name
  internal_load_balancer_enabled = true
  infrastructure_subnet_id       = azurerm_subnet.container_subnet.id
}

resource "azurerm_container_app" "app" {
  container_app_environment_id = azurerm_container_app_environment.app_env.id
  name                         = var.app_name
  resource_group_name          = azurerm_resource_group.app_rg.name
  revision_mode                = "Single"
  template {
    container {
      cpu    = 0.25
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      memory = "0.5Gi"
      name   = "hello-world"
    }
  }
  ingress {
    target_port      = 80
    external_enabled = false
    traffic_weight {
      percentage = 100
    }
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "acr_pull_role" {
  principal_id         = azurerm_container_app.app.identity[0].principal_id
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
}
