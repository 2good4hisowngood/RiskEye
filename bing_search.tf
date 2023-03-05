resource "azurerm_logic_app_workflow" "bing" {
  name                = "bing-search${random_integer.storage_id.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}



# Code for logic app

# {
#     "definition": {
#         "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
#         "actions": {
#             "For_each_technology_identified": {
#                 "actions": {
#                     "For_each_search_result": {
#                         "actions": {
#                             "Create_blob_(V2)": {
#                                 "inputs": {
#                                     "body": "@body('Get_content_from_url')",
#                                     "headers": {
#                                         "ReadFileMetadataFromServer": true
#                                     },
#                                     "host": {
#                                         "connection": {
#                                             "name": "@parameters('$connections')['azureblob_1']['connectionId']"
#                                         }
#                                     },
#                                     "method": "post",
#                                     "path": "/v2/datasets/@{encodeURIComponent(encodeURIComponent('AccountNameFromSettings'))}/files",
#                                     "queries": {
#                                         "folderPath": "/technologies",
#                                         "name": "@{items('For_each_search_result')?['name']}.html",
#                                         "queryParametersSingleEncoded": true
#                                     }
#                                 },
#                                 "runAfter": {
#                                     "Get_content_from_url": [
#                                         "Succeeded"
#                                     ]
#                                 },
#                                 "runtimeConfiguration": {
#                                     "contentTransfer": {
#                                         "transferMode": "Chunked"
#                                     }
#                                 },
#                                 "type": "ApiConnection"
#                             },
#                             "Get_content_from_url": {
#                                 "inputs": {
#                                     "method": "GET",
#                                     "uri": "@items('For_each_search_result')?['url']"
#                                 },
#                                 "runAfter": {},
#                                 "type": "Http"
#                             }
#                         },
#                         "foreach": "@body('Search_for_news_on_that_technology')",
#                         "runAfter": {
#                             "Search_for_news_on_that_technology": [
#                                 "Succeeded"
#                             ]
#                         },
#                         "type": "Foreach"
#                     },
#                     "Search_for_news_on_that_technology": {
#                         "inputs": {
#                             "host": {
#                                 "connection": {
#                                     "name": "@parameters('$connections')['bingsearch_1']['connectionId']"
#                                 }
#                             },
#                             "method": "get",
#                             "path": "/news/search",
#                             "queries": {
#                                 "count": "20",
#                                 "mkt": "en-US",
#                                 "q": "@{items('For_each_technology_identified')} danger",
#                                 "safeSearch": "Moderate"
#                             }
#                         },
#                         "runAfter": {},
#                         "type": "ApiConnection"
#                     }
#                 },
#                 "foreach": "@variables('technologies')",
#                 "runAfter": {
#                     "Initialize_variable": [
#                         "Succeeded"
#                     ]
#                 },
#                 "type": "Foreach"
#             },
#             "Initialize_variable": {
#                 "inputs": {
#                     "variables": [
#                         {
#                             "name": "technologies",
#                             "type": "array",
#                             "value": [
#                                 "lithium ion battery",
#                                 "tesla",
#                                 "self driving"
#                             ]
#                         }
#                     ]
#                 },
#                 "runAfter": {},
#                 "type": "InitializeVariable"
#             }
#         },
#         "contentVersion": "1.0.0.0",
#         "outputs": {},
#         "parameters": {
#             "$connections": {
#                 "defaultValue": {},
#                 "type": "Object"
#             }
#         },
#         "triggers": {
#             "Recurrence": {
#                 "evaluatedRecurrence": {
#                     "frequency": "Day",
#                     "interval": 3
#                 },
#                 "recurrence": {
#                     "frequency": "Day",
#                     "interval": 3
#                 },
#                 "type": "Recurrence"
#             }
#         }
#     },
#     "parameters": {
#         "$connections": {
#             "value": {
#                 "azureblob_1": {
#                     "connectionId": "/subscriptions/fe47f131-cb44-477f-82a5-7c19ca0fd15a/resourceGroups/533/providers/Microsoft.Web/connections/azureblob-1",
#                     "connectionName": "azureblob-1",
#                     "id": "/subscriptions/fe47f131-cb44-477f-82a5-7c19ca0fd15a/providers/Microsoft.Web/locations/eastus/managedApis/azureblob"
#                 },
#                 "bingsearch_1": {
#                     "connectionId": "/subscriptions/fe47f131-cb44-477f-82a5-7c19ca0fd15a/resourceGroups/533/providers/Microsoft.Web/connections/bingsearch-1",
#                     "connectionName": "bingsearch-1",
#                     "id": "/subscriptions/fe47f131-cb44-477f-82a5-7c19ca0fd15a/providers/Microsoft.Web/locations/eastus/managedApis/bingsearch"
#                 }
#             }
#         }
#     }
# }