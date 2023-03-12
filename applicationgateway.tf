 # Create application gateway
resource "azurerm_application_gateway" "rolax" {
  name                = "rolax-app-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "rolax-gateway-ip-config"
    subnet_id = azurerm_subnet.public.id
  }

  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name      = "rolax-frontend-ip-config"
    subnet_id = azurerm_subnet.public.id
  }

  backend_address_pool {
    name = "rolax-backend-pool"
  }

  http_listener {
    name                           = "rolax-http-listener"
    frontend_ip_configuration_id  = azurerm_application_gateway.rolax.frontend_ip_configuration[0].id
    frontend_port_id              = azurerm_application_gateway.rolax.frontend_port[0].id
    protocol                       = "Http"
    require_server_name_indication = false
  }

  request_routing_rule {
    name                       = "rolax-routing-rule"
    rule_type                  = "Basic"
    http_listener_id           = azurerm_application_gateway.rolax.http_listener[0].id
    backend_address_pool_id    = azurerm_application_gateway.rolax.backend_address_pool[0].id
    backend_http_settings_id   = azurerm_application_gateway.rolax.backend_http_settings[0].id
    http_listener_name         = azurerm_application_gateway.rolax.http_listener[0].name
    backend_address_pool_name  = azurerm_application_gateway.rolax.backend_address_pool[0].name
    backend_http_settings_name = azurerm_application_gateway.rolax.backend_http_settings[0].name
  }
  backend_http_settings {
    name                           = "my-backend-http-settings"
    cookie_based_affinity          = "Disabled"
    port                           = 80
    protocol                       = "Http"
    request_timeout                = 20
    probe_name                     = "my-probe"
    path                           = "/"
    pick_host_name_from_backend_address = true
  }

  probe {
    name                      = "rolax-probe"
    protocol                  = "Http"
    host                      = "localhost"
    path                      = "/"
    interval                  = 30
    timeout                   = 120
    unhealthy_threshold_count = 3
  }
}