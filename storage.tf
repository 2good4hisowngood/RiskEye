# Storage Accounts:

# For project documents
resource "azurerm_storage_account" "example" {
  name                     = "projectstorage${random_integer.storage_id.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Project Blob
resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example1" {
  name                   = "Home Security System Technical Document 1.txt"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "doc1.txt"
}

# resource "azurerm_storage_blob" "example2" {
#   name                   = "Home Security System Technical Document 2.txt"
#   storage_account_name   = azurerm_storage_account.example.name
#   storage_container_name = azurerm_storage_container.example.name
#   type                   = "Block"
#   source                 = "doc2.txt"
# }