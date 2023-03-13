# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.10.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
# Create subnets
resource "azurerm_subnet" "private" {
  name                 = "rolax-private-subnet"
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.rg.name
  resource_group_name  = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "public" {
  name                 = "rolax-public-subnet"
  address_prefixes     = ["10.0.2.0/24"]
  virtual_network_name = azurerm_virtual_network.rg.name
  resource_group_name  = azurerm_resource_group.rg.name
}


#   subnet {
#     name           = "PrivateSubnet"
#     address_prefix = "10.10.1.0/24"
#   }
# }