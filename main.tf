# Baseline Azure Resource Group demonstration
# This resource requires only two arguments: name and location.
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
