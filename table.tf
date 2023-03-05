# This is the table that will track the technologies that are being used for each product.
resource "azurerm_storage_table" "example" {
  name                 = "technologies"
  storage_account_name = azurerm_storage_account.example.name
}