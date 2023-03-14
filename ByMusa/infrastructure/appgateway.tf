locals {
  appgw_fe_port        = "frontend-port"
  appgw_listener_name  = "appgw-listener"
  frontend_ip_config   = "frontend-ip-config"
  backend_http_setting = "container-backend-settings"
  backend_address_pool = "container-apps"
}
# resource "azurerm_resource_group" "gateway_rg" {
#   location = var.gateway_location
#   name     = var.gateway_rg_name
# }

# resource "azurerm_public_ip" "appgw_pip" {
#   allocation_method   = "Dynamic"
#   location            = azurerm_resource_group.gateway_rg.location
#   name                = "pip-appgw"
#   resource_group_name = azurerm_resource_group.gateway_rg.name
# }

# resource "azurerm_application_gateway" "app_gateway" {
#   location            = var.gateway_location
#   name                = var.gateway_name
#   resource_group_name = azurerm_resource_group.gateway_rg.name
#   backend_address_pool {
#     name  = local.backend_address_pool
#     fqdns = [azurerm_container_app.app.latest_revision_fqdn]
#   }
#   backend_http_settings {
#     cookie_based_affinity = "Disabled"
#     name                  = local.backend_http_setting
#     port                  = 80
#     protocol              = "Http"
#     request_timeout       = 60
#   }
#   frontend_ip_configuration {
#     name                 = local.frontend_ip_config
#     public_ip_address_id = azurerm_public_ip.appgw_pip.id
#   }
#   frontend_port {
#     name = local.appgw_fe_port
#     port = 80
#   }
#   gateway_ip_configuration {
#     name      = "gateway-ip-configuration"
#     subnet_id = azurerm_subnet.appgw_subnet.id
#   }
#   http_listener {
#     frontend_ip_configuration_name = local.frontend_ip_config
#     frontend_port_name             = local.appgw_fe_port
#     name                           = local.appgw_listener_name
#     protocol                       = "Http"
#   }
#   request_routing_rule {
#     http_listener_name         = local.appgw_listener_name
#     name                       = "request-routing"
#     rule_type                  = "Basic"
#     backend_http_settings_name = local.backend_http_setting
#     backend_address_pool_name  = local.backend_address_pool
#   }
#   sku {
#     name     = "Standard_Small"
#     tier     = "Standard"
#     capacity = 2
#   }

#   timeouts {
#     create = "2h"
#     delete = "2h"
#     update = "2h"
#     read   = "30m"
#   }
# }
