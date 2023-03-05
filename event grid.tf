resource "azurerm_eventgrid_domain" "example" {
  name                = "my-eventgrid-domain"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    environment = "Production"
  }
}