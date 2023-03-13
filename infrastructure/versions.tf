terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.47.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "pRG-Terraform"
    storage_account_name = "pstrgaccountmusa"
    container_name       = "tfstate"
    key                  = "dev/app.tfstate"
  }
}

provider "azurerm" {
  features {}
}
