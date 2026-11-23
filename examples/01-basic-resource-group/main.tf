# Self-contained baseline Resource Group example
resource "azurerm_resource_group" "demo" {
  name     = "rg-fundamentals-example"
  location = "eastus"
}
