resource "azurerm_log_analytics_workspace" "rolaxresortsla" {
  name                = var.azurerm_log_analytics_workspace
  location            = var.location
  resource_group_name = var.resource_group_name

}