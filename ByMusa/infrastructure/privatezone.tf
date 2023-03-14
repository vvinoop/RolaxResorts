# resource "azurerm_private_dns_zone" "private_zone" {
#   name                = var.private_zone_name
#   resource_group_name = azurerm_resource_group.vnet_rg.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
#   name                  = "containerapps-vnet"
#   private_dns_zone_name = azurerm_private_dns_zone.private_zone.name
#   resource_group_name   = azurerm_resource_group.vnet_rg.name
#   virtual_network_id    = azurerm_virtual_network.vnet.id
#   registration_enabled  = true
# }

# resource "azurerm_private_dns_a_record" "container_record" {
#   name                = replace(azurerm_container_app.app.latest_revision_fqdn, ".${var.private_zone_name}", "")
#   records             = [azurerm_container_app_environment.app_env.static_ip_address]
#   resource_group_name = azurerm_resource_group.vnet_rg.name
#   ttl                 = 3600
#   zone_name           = azurerm_private_dns_zone.private_zone.name
# }
