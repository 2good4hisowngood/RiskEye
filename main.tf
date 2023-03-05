# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "TechNewsWatcherProject"
  location = "eastus"
}

resource "random_integer" "storage_id" {
  min = 0
  max = 99999
}