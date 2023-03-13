terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.43.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
    tenant_id= "301653bc-78e3-44a3-a0d2-1565d5bb4dcb"
    subscription_id= "44dacde6-8608-413c-a507-73a91aa45940"
  features {}
}
# Create two virtual machines in two availability zones and add them to the private subnets
resource "azurerm_linux_virtual_machine" "vm1" {
    # Define the Azure provider
provider "azurerm" {
  features {}
}

# Define the resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus2"
}

# Define the virtual network
resource "azurerm_virtual_network" "example" {
  name                = "example-virtual-network"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  address_space       = ["10.0.0.0/16"]
}

# Define the two subnets
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefix       = "10.0.2.0/24"
}

# Define the availability set
resource "azurerm_availability_set" "example" {
  name                = "example-availability-set"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  platform_fault_domain_count = 2
  platform_update_domain_count = 2
}

# Define the network interface for the first VM
resource "azurerm_network_interface" "nic1" {
  name                = "nic1"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${azurerm_subnet.subnet1.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the network interface for the second VM
resource "azurerm_network_interface" "nic2" {
  name                = "nic2"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"

  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = "${azurerm_subnet.subnet2.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine for the first subnet
resource "azurerm_virtual_machine" "vm1" {
  name                  = "vm1"
  location              = "${azurerm_resource_group.example.location}"
  resource_group_name   = "${azurerm_resource_group.example.name}"
  network_interface_ids = ["${azurerm_network_interface.nic1.id}"]
  availability_set_id   = "${azurerm_availability_set.example.id}"
  vm_size               = "Standard_B2ms"

  storage_os_disk {
    name              = "osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}