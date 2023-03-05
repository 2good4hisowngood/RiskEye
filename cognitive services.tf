# resource "azurerm_cognitive_account" "example" {
#   name                = "example-ca"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   kind                = "OpenAI"
#   sku_name            = "S0"
# }

# resource "azurerm_cognitive_deployment" "example" {
#   name                 = "example-cd"
#   cognitive_account_id = azurerm_cognitive_account.example.id
#   model {
#     format  = "OpenAI"
#     name    = "text-curie-001"
#     version = "1"
#   }

#   scale {
#     type = "Standard"
#   }
# }


resource "azurerm_search_service" "example" {
  name                = "example-search-service-533"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "standard"
}

# Instructions:
# Go to search service
# Go to Semantic search (Preview) tab, and enable it
# Go to Overview > Import Data Select Blob storage in the Data Source dropdown and then click "Choose an existing connection"
# Select the storage account and blob container for the Bing search results. Click next through following sections until done.
# Launch storage explorer > Expand Query options and turn on the options.

# create configuration
# Needs list of keywords for keyword field, 
# Semantic search uses deep neural networks to provide relevant results and answers based on semantics, not just lexical analysis. Additional charges may be applicable. 
# choose configuration

# Add a Query of "Cause of failure" and click Search