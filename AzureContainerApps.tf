resource "azurerm_container_app_environment" "rolaxresorts" {
  name                       = var.azurerm_container_app_environment
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.rolaxresorts.id
}
resource "azurerm_container_app" "rolaxresorts" {
  name                         = var.azurerm_container_app
  container_app_environment_id = azurerm_container_app_environment.rolaxresorts.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "1rolaxresortscontainerapp-test1"
      image  = "rolaxresortscr.azurecr.io/rolax-resort-image:v1"
      cpu    = 0.5
      memory = "1Gi"
    }
  }
}