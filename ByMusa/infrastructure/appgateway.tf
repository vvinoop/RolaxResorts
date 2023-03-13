locals {
  appgw_fe_port       = "frontend-port"
  appgw_listener_name = "appgw-listener"
}
resource "azurerm_resource_group" "gateway_rg" {
  location = var.gateway_location
  name     = var.gateway_rg_name
}

resource "azurerm_application_gateway" "app_gateway" {
  location            = var.gateway_location
  name                = var.gateway_name
  resource_group_name = azurerm_resource_group.gateway_rg.name
  backend_address_pool {
    name = "container-apps"
  }
  backend_http_settings {
    cookie_based_affinity = "Disabled"
    name                  = "container-backend-settings"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }
  frontend_ip_configuration {
    name = "gateway-frontend"
  }
  frontend_port {
    name = local.appgw_fe_port
    port = 80
  }
  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = azurerm_subnet.appgw_subnet.id
  }
  http_listener {
    frontend_ip_configuration_name = "frontend-config"
    frontend_port_name             = local.appgw_fe_port
    name                           = local.appgw_listener_name
    protocol                       = "Http"
  }
  request_routing_rule {
    http_listener_name = local.appgw_listener_name
    name               = "request-routing"
    rule_type          = "Basic"
  }
  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }
}
