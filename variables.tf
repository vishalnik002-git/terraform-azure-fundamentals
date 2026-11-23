variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group."
  default     = "rg-fundamentals-dev"
}

variable "resource_group_location" {
  type        = string
  description = "The Azure region where resources will be created."
  default     = "eastus"
}
