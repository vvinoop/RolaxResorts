variable "vnet_rg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_location" {
  type = string
}
variable "log_rg_name" {
  type = string
}

variable "log_name" {
  type = string
}

variable "log_location" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "acr_location" {
  type = string
}

variable "acr_rg_name" {
  type = string
}

variable "acr_sku" {
  type    = string
  default = "Basic"
}

variable "app_rg_name" {
  type = string
}

variable "app_env_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_location" {
  type = string
}
