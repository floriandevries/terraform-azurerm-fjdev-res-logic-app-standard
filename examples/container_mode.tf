module "logic_app_standard" {
  source = "git::https://github.com/Cegeka-Hybrid-Cloud/pc-cc-terraform-azurerm-cgk-res-logic-app-standard.git?ref=v1.0.0"

  name                       = "example-logic-app"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  site_config = {
    linux_fx_version = "DOCKER|mcr.microsoft.com/azure-functions/dotnet:3.0-appservice"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://<server-name>.azurecr.io"
    "DOCKER_REGISTRY_SERVER_USERNAME" = "username"
    "DOCKER_REGISTRY_SERVER_PASSWORD" = "password"
  }
}