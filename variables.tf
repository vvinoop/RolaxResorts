# Generic Input varibles
# Project scenario
variable "project" {
  description = "Project scenario name"
  type = string
  default = "rolaxresorts"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  default     = "dev"
}
# Azure resource group name
variable "resource_group_name" {
  description = "Value of the Name tag for the resource group"
  type        = string
  default     = "rolaxresorts"
}

variable "location" {
  description = "location of the resource group"
  type        = string  
  default     = "uksouth"
}


variable "vnet_name" {
  description = "Value of the Name tag for the vnet"
  type        = string
  default     = "rolaxresortsvnet"
}
variable "vnet_address_space" {
  description = "adress space for virtual network"
  type        = list(any) 
  default     = ["10.0.10.0/16"]
}

variable "snet_address_space" {
  description = "adress space for subnet"
  type        = list(any) 
  default     = ["10.10.1.0/24"]
}

variable "azurerm_log_analytics_workspace" {
  description = "Value of the Log Analytics workspace"
  type        = string
  default     = "rolaxresortsla"
}
variable "azurerm_container_registry" {
  description = "Value of the Name tag for the Container registry"
  type        = string
  default     = "rolaxresortscr"
}

variable "azurerm_container_app_environment" {
  description = "Value of the Name tag for the Container app environment"
  type        = string
  default     = "rolaxresortscappenv"
}

variable "azurerm_container_app" {
  description = "Value of the Name tag for the Container app"
  type        = string
  default     = "rolaxresortscapp"
}
