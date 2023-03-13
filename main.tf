# Configure the Azure provider
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

resource "azurerm_resource_group" "rg" {
  name     = "rolaxresorts"
  location = "uksouth"
  tags = {
      "Cloud Unit"="Hubble"
      "Contact"="vinoop.vayath@and.digital"
      "Life-span"="4 weeks"
      "Owner"="Vinoop Vayath"
  }
}

# resource "azurerm_virtual_network" "vnet" {
#   name     = "rolaxresorts"

# }
