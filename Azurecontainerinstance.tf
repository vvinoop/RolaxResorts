# Container Group
resource "azurerm_container_group" "containergroup" {
  name                = "rolax-container-group"
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type = "Linux"

  # Container definition
  container {
    name   = "rolax-container"
    # for example - rolaxcontainerregistry.azurecr.io/rolax-resort-image:v1
    image  = join("/", [azurerm_container_registry.acr.name,"rolax-resort-image:v1"])
    cpu    = "0.5"
    memory = "1.5"

    # Port mapping
    port {
      protocol = "TCP"
      port     = 80
    }
  }

  # Network profile
  ip_address_type = "Private"
  subnet_id       = azurerm_subnet.private.id
}
