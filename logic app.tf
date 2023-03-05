resource "azurerm_service_plan" "example" {
  name                = "app-service-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "text_search" {
  name                = "text-search${random_integer.storage_id.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  site_config {}
}

resource "azurerm_logic_app_workflow" "example" {
  name                = "text-search${random_integer.storage_id.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}



# app json in progress

# {
#     "definition": {
#         "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
#         "actions": {
#             "Get_blob_content_(V2)": {
#                 "inputs": {
#                     "host": {
#                         "connection": {
#                             "name": "@parameters('$connections')['azureblob']['connectionId']"
#                         }
#                     },
#                     "method": "get",
#                     "path": "/v2/datasets/@{encodeURIComponent(encodeURIComponent('AccountNameFromSettings'))}/files/@{encodeURIComponent(encodeURIComponent('JTJmdGVjaG5vbG9naWVzJTJmdGVjaG5vbG9naWVzLmNzdg=='))}/content",
#                     "queries": {
#                         "inferContentType": true
#                     }
#                 },
#                 "metadata": {
#                     "JTJmdGVjaG5vbG9naWVzJTJmdGVjaG5vbG9naWVzLmNzdg==": "/technologies/technologies.csv"
#                 },
#                 "runAfter": {},
#                 "type": "ApiConnection"
#             },
#             "Get_list_of_files_in_this_project": {
#                 "actions": {
#                     "Get_files": {
#                         "inputs": {
#                             "host": {
#                                 "connection": {
#                                     "name": "@parameters('$connections')['azurefile']['connectionId']"
#                                 }
#                             },
#                             "method": "get",
#                             "path": "/datasets/default/foldersV2/@{encodeURIComponent(encodeURIComponent(items('Get_list_of_files_in_this_project')?['Path']))}",
#                             "queries": {
#                                 "nextPageMarker": "",
#                                 "useFlatListing": false
#                             }
#                         },
#                         "runAfter": {},
#                         "type": "ApiConnection"
#                     },
#                     "Get_the_file_content_of_that_file": {
#                         "actions": {
#                             "Check_that_doc_for_the_listed_technologies": {
#                                 "actions": {
#                                     "Condition": {
#                                         "actions": {
#                                             "Append_to_array_variable": {
#                                                 "inputs": {
#                                                     "name": "project-techs",
#                                                     "value": "@items('Check_that_doc_for_the_listed_technologies')"
#                                                 },
#                                                 "runAfter": {},
#                                                 "type": "AppendToArrayVariable"
#                                             }
#                                         },
#                                         "expression": {
#                                             "and": [
#                                                 {
#                                                     "contains": [
#                                                         "@body('Get_file_content')",
#                                                         "@items('Check_that_doc_for_the_listed_technologies')"
#                                                     ]
#                                                 }
#                                             ]
#                                         },
#                                         "runAfter": {},
#                                         "type": "If"
#                                     }
#                                 },
#                                 "foreach": "@variables('technologies')",
#                                 "runAfter": {
#                                     "Get_file_content": [
#                                         "Succeeded"
#                                     ]
#                                 },
#                                 "type": "Foreach"
#                             },
#                             "Get_file_content": {
#                                 "inputs": {
#                                     "host": {
#                                         "connection": {
#                                             "name": "@parameters('$connections')['azurefile']['connectionId']"
#                                         }
#                                     },
#                                     "method": "get",
#                                     "path": "/datasets/default/files/@{encodeURIComponent(encodeURIComponent(items('Get_the_file_content_of_that_file')?['Path']))}/content",
#                                     "queries": {
#                                         "inferContentType": true
#                                     }
#                                 },
#                                 "runAfter": {},
#                                 "type": "ApiConnection"
#                             }
#                         },
#                         "foreach": "@body('Get_files')?['value']",
#                         "runAfter": {
#                             "Get_files": [
#                                 "Succeeded"
#                             ]
#                         },
#                         "type": "Foreach"
#                     }
#                 },
#                 "foreach": "@body('Get_list_of_project_files')?['value']",
#                 "runAfter": {
#                     "Get_list_of_project_files": [
#                         "Succeeded"
#                     ]
#                 },
#                 "type": "Foreach"
#             },
#             "Get_list_of_project_files": {
#                 "inputs": {
#                     "host": {
#                         "connection": {
#                             "name": "@parameters('$connections')['azurefile']['connectionId']"
#                         }
#                     },
#                     "method": "get",
#                     "path": "/datasets/default/foldersV2/@{encodeURIComponent(encodeURIComponent('JTJmcHJvamVjdHM='))}",
#                     "queries": {
#                         "nextPageMarker": "",
#                         "useFlatListing": false
#                     }
#                 },
#                 "metadata": {
#                     "JTJmcHJvamVjdHM=": "/projects"
#                 },
#                 "runAfter": {
#                     "Initialize_variable": [
#                         "Succeeded"
#                     ]
#                 },
#                 "type": "ApiConnection"
#             },
#             "Initialize_technologies_array_variable": {
#                 "inputs": {
#                     "variables": [
#                         {
#                             "name": "technologies",
#                             "type": "array",
#                             "value": "@split(body('Get_blob_content_(V2)'), ',')"
#                         }
#                     ]
#                 },
#                 "runAfter": {
#                     "Get_blob_content_(V2)": [
#                         "Succeeded"
#                     ]
#                 },
#                 "type": "InitializeVariable"
#             },
#             "Initialize_variable": {
#                 "inputs": {
#                     "variables": [
#                         {
#                             "name": "project-techs",
#                             "type": "array"
#                         }
#                     ]
#                 },
#                 "runAfter": {
#                     "Initialize_technologies_array_variable": [
#                         "Succeeded"
#                     ]
#                 },
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
#             "manual": {
#                 "inputs": {},
#                 "kind": "Http",
#                 "type": "Request"
#             }
#         }
#     },
#     "parameters": {
#         "$connections": {
#             "value": {
#                 "azureblob": {
#                     "connectionId": "/subscriptions/fe47f131-cb44-477f-82a5-7c19ca0fd15a/resourceGroups/533/providers/Microsoft.Web/connections/azureblob-1",
#                     "connectionName": "azureblob-1",
#                     "id": "/subscriptions/fe47f131-cb44-477f-82a5-7c19ca0fd15a/providers/Microsoft.Web/locations/eastus/managedApis/azureblob"
#                 },
#                 "azurefile": {
#                     "connectionId": "/subscriptions/fe47f131-cb44-477f-82a5-7c19ca0fd15a/resourceGroups/533/providers/Microsoft.Web/connections/azurefile",
#                     "connectionName": "azurefile",
#                     "id": "/subscriptions/fe47f131-cb44-477f-82a5-7c19ca0fd15a/providers/Microsoft.Web/locations/eastus/managedApis/azurefile"
#                 }
#             }
#         }
#     }
# }