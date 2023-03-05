# resource "azurerm_stream_analytics_cluster" "example" {
#   name                = "examplestreamanalyticscluster"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   streaming_capacity  = 36
# }