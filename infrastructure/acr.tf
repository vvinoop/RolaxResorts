resource "azurerm_resource_group" "acr_rg" {
  location = var.acr_location
  name     = var.acr_rg_name
}

resource "azurerm_container_registry" "acr" {
  location               = var.acr_location
  name                   = var.acr_name
  resource_group_name    = azurerm_resource_group.acr_rg.name
  sku                    = var.acr_sku
  admin_enabled          = true
  anonymous_pull_enabled = false
}
