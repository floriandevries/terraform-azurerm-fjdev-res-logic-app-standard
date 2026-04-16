output "custom_domain_verification_id" {
  description = "An identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = azurerm_logic_app_standard.logic.custom_domain_verification_id
}

output "default_hostname" {
  description = "The default hostname associated with the Logic App - such as `mysite.azurewebsites.net`."
  value       = azurerm_logic_app_standard.logic.default_hostname
}

output "id" {
  description = "The ID of the Logic App."
  value       = azurerm_logic_app_standard.logic.id
}

output "identity" {
  description = <<DESCRIPTION
An `identity` block as defined below, which contains the Managed Service Identity information for this App Service.
- `principal_id`    - The Principal ID for the Service Principal associated with the Managed Service Identity of this App Service.
- `tenant_id`       - The Tenant ID for the Service Principal associated with the Managed Service Identity of this App Service.
DESCRIPTION
  value       = azurerm_logic_app_standard.logic.identity
}

output "kind" {
  description = "The Logic App kind."
  value       = azurerm_logic_app_standard.logic.kind
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses - such as `52.23.25.3,52.143.43.12`."
  value       = azurerm_logic_app_standard.logic.outbound_ip_addresses
}

output "possible_outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses - such as `52.23.25.3,52.143.43.12,52.143.43.17` - not all of which are necessarily in use. Superset of `outbound_ip_addresses`."
  value       = azurerm_logic_app_standard.logic.possible_outbound_ip_addresses
}

output "site_credential" {
  description = <<DESCRIPTION
A `site_credential` block as defined below, which contains the site-level credentials used to publish to this App Service.
- `username`    - The username for the site-level credentials.
- `password`    - The password for the site-level credentials.
DESCRIPTION
  sensitive   = true
  value       = azurerm_logic_app_standard.logic.site_credential
}
