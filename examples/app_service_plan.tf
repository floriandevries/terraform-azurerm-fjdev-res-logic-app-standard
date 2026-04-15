module "logic_app_standard" {
  source = "git::https://github.com/Cegeka-Hybrid-Cloud/pc-cc-terraform-azurerm-cgk-res-logic-app-standard.git?ref=v1.0.0"

  name                       = "example-logic-app"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  }
}