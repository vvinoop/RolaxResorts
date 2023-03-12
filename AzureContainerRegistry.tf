resource "azurerm_container_registry" "acr" {
  name                = var.azurerm_container_registry
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false

#  Availability zones are only available on Premium SKU
#   georeplications {
#     location                = "ukwest"
#     zone_redundancy_enabled = true
#     tags                    = {}
#   }
}