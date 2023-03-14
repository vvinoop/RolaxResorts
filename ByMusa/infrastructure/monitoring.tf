resource "azurerm_resource_group" "log_rg" {
  location = var.log_location
  name     = var.log_rg_name
}

resource "azurerm_log_analytics_workspace" "log_workspace" {
  location            = var.log_location
  name                = var.log_name
  resource_group_name = azurerm_resource_group.log_rg.name
}

