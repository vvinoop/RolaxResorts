resource "azurerm_resource_group" "vnet_rg" {
  location = var.vnet_location
  name     = var.vnet_rg_name

}

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.1.0.0/16"]
  location            = var.vnet_location
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_subnet" "default" {
  address_prefixes     = ["10.1.0.0/24"]
  name                 = "default"
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

# resource "azurerm_subnet" "appgw_subnet" {
#   address_prefixes     = ["10.1.1.0/24"]
#   name                 = "app-gateway-subnet"
#   resource_group_name  = azurerm_resource_group.vnet_rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
# }

resource "azurerm_subnet" "container_subnet" {
  address_prefixes     = ["10.1.2.0/23"]
  name                 = "container-subnet"
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}
