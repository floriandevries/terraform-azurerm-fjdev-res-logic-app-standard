variable "app_service_plan_id" {
  type        = string
  description = "The ID of the App Service Plan within which to create this Logic App."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "name" {
  type        = string
  description = "Specifies the name of the Logic App. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Logic App. Changing this forces a new resource to be created."
}

variable "storage_account_access_key" {
  type        = string
  description = "The access key which will be used to access the backend storage account for the Logic App."
}

variable "storage_account_name" {
  type        = string
  description = "The backend storage account name which will be used by this Logic App (e.g. for Stateful workflows data). Changing this forces a new resource to be created."
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = <<DESCRIPTION
A map of key-value pairs for [App Settings](https://docs.microsoft.com/azure/azure-functions/functions-app-settings) and custom values.
> Note: There are a number of application settings that will be managed for you by this resource type and shouldn't be configured separately as part of the `app_settings` you specify. `AzureWebJobsStorage` is filled based on `storage_account_name` and `storage_account_access_key`. `WEBSITE_CONTENTSHARE` is detailed below. `FUNCTIONS_EXTENSION_VERSION` is filled based on `version`. `APP_KIND` is set to `workflowApp` and `AzureFunctionsJobHost__extensionBundle__id` and `AzureFunctionsJobHost__extensionBundle__version` are set as detailed below.
DESCRIPTION
}

variable "bundle_version" {
  type        = string
  default     = "[1.*, 2.0.0)"
  description = "If `use_extension_bundle` is set to `true` this controls the allowed range for bundle versions."
}

variable "client_affinity_enabled" {
  type        = bool
  default     = null
  description = "Should the Logic App send session affinity cookies, which route client requests in the same session to the same instance?"
}

variable "client_certificate_mode" {
  type        = string
  default     = null
  description = "The mode of the Logic App's client certificates requirement for incoming requests. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`."

  validation {
    condition     = contains(["Required", "Optional", "OptionalInteractiveUser"], var.client_certificate_mode)
    error_message = "The value of `client_certificate_mode` must be one of 'Required', 'Optional', or 'OptionalInteractiveUser'."
  }
}

variable "connection_string" {
  type = object({
    name  = string
    type  = string
    value = string
  })
  default     = null
  description = <<DESCRIPTION
A `connection_string` block as defined below.
- `name`    - The name of the Connection String.
- `type`    - The type of the Connection String. Possible values are `APIHub`, `Custom`, `DocDb`, `EventHub`, `MySQL`, `NotificationHub`, `PostgreSQL`, `RedisCache`, `ServiceBus`, `SQLAzure` and `SQLServer`.
- `value`   - The value of the Connection String.
DESCRIPTION
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Is the Logic App enabled?"
}

variable "ftp_publish_basic_authentication_enabled" {
  type        = bool
  default     = true
  description = "Whether the FTP basic authentication publishing profile is enabled."
}

variable "https_only" {
  type        = bool
  default     = false
  description = "Can the Logic App only be accessed via HTTPS?"
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default     = null
  description = <<DESCRIPTION
An `identity` block as defined below.
- `type`         - Specifies the type of Managed Service Identity that should be configured on this Logic App Standard. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned` (to enable both).
- `identity_ids` - Specifies a list of User Assigned Managed Identity IDs to be assigned to this Logic App Standard.
> Note: When `type` is set to `SystemAssigned`, the assigned `principal_id` and `tenant_id` can be retrieved after the Logic App has been created. More details are available below.
> Note: The `identity_ids` is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`.
DESCRIPTION
}

variable "public_network_access" {
  type        = string
  default     = "Enabled"
  description = <<DESCRIPTION
Whether Public Network Access should be enabled or not. Possible values are `Enabled` and `Disabled`.
> Note: Setting this property will also set it in the Site Config.
DESCRIPTION

  validation {
    condition     = contains(["Enabled", "Disabled"], var.public_network_access)
    error_message = "The value of `public_network_access` must be either 'Enabled' or 'Disabled'."
  }
}

variable "scm_publish_basic_authentication_enabled" {
  type        = bool
  default     = true
  description = "Whether the default SCM basic authentication publishing profile is enabled."
}

variable "site_config" {
  type = object({
    always_on           = optional(bool, false)
    app_scale_limit     = optional(number)
    auto_swap_slot_name = optional(string)
    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    }))
    dotnet_framework_version = optional(string, "v4.0")
    elastic_instance_minimum = optional(number)
    ftps_state               = optional(string, "AllAllowed")
    health_check_path        = optional(string)
    http2_enabled            = optional(bool, false)
    ip_restriction = optional(list(object({
      ip_address                = optional(string)
      description               = optional(string)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      action                    = optional(string, "Allow")
      headers = optional(object({
        x_azure_fdid      = optional(string)
        x_fd_health_probe = optional(string)
        x_forwarded_for   = optional(string)
        x_forwarded_host  = optional(string)
      }))
    })))
    scm_ip_restriction = optional(list(object({
      ip_address                = optional(string)
      description               = optional(string)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      action                    = optional(string, "Allow")
      headers = optional(object({
        x_azure_fdid      = optional(string)
        x_fd_health_probe = optional(string)
        x_forwarded_for   = optional(string)
        x_forwarded_host  = optional(string)
      }))
    })))
    scm_use_main_ip_restriction      = optional(bool, false)
    scm_min_tls_version              = optional(string)
    scm_type                         = optional(string)
    linux_fx_version                 = optional(string)
    min_tls_version                  = optional(string, "1.2")
    pre_warmed_instance_count        = optional(number)
    runtime_scale_monitoring_enabled = optional(bool, false)
    use_32_bit_worker_process        = optional(bool, true)
    vnet_route_all_enabled           = optional(bool)
    websockets_enabled               = optional(bool)
  })
  default     = null
  description = <<DESCRIPTION
A `site_config` block as defined below.
- `always_on`                         - (Optional) Should the Logic App be loaded at all times? Defaults to `false`.
- `app_scale_limit`                   - (Optional) The number of workers this Logic App can scale out to. Only applicable to apps on the Consumption and Premium plan.
- `auto_swap_slot_name`               - (Optional) The Auto-swap slot name.
- `cors`                              - (Optional) A `cors` block as defined below.
  - `allowed_origins`     - A list of origins which should be able to make cross-origin calls. `*` can be used to allow all calls.
  - `support_credentials` - (Optional) Are credentials supported?
- `dotnet_framework_version`          - (Optional) The version of the .NET framework's CLR used in this Logic App Possible values are `v4.0` (including .NET Core 2.1 and 3.1), `v5.0`, `v6.0` and `v8.0`. [For more information on which .NET Framework version to use based on the runtime version you're targeting - please see this table](https://docs.microsoft.com/azure/azure-functions/functions-dotnet-class-library#supported-versions). Defaults to `v4.0`.
- `elastic_instance_minimum`          - (Optional) The number of minimum instances for this Logic App Only affects apps on the Premium plan.
- `ftps_state`                        - (Optional) State of FTP / FTPS service for this Logic App Possible values include: `AllAllowed`, `FtpsOnly` and `Disabled`. Defaults to `AllAllowed`.
- `health_check_path`                 - (Optional) Path which will be checked for this Logic App health.
- `http2_enabled`                     - (Optional) Specifies whether or not the HTTP2 protocol should be enabled. Defaults to `false`.
- `ip_restriction`                    - (Optional) A list of `ip_restriction` objects representing IP restrictions as defined below.
  - `ip_address`                - (Optional) The IP Address used for this IP Restriction in CIDR notation.
  - `description`               - (Optional) The Description of this IP Restriction.
  - `service_tag`               - (Optional) The Service Tag used for this IP Restriction.
  - `virtual_network_subnet_id` - (Optional) The Virtual Network Subnet ID used for this IP Restriction.
  > Note: One of either `ip_address`, `service_tag` or `virtual_network_subnet_id` must be specified.
  - `name`                      - (Optional) The name for this IP Restriction.
  - `priority`                  - (Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to `65000` if not specified.
  - `action`                    - (Optional) Does this restriction `Allow` or `Deny` access for this IP range. Defaults to `Allow`.
  - `headers`                   - (Optional) The headers block for this specific `ip_restriction` as defined below.
    - `x_azure_fdid`      - (Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.
    - `x_fd_health_probe` - (Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".
    - `x_forwarded_for`   - (Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8.
    - `x_forwarded_host`  - (Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.
> Note: User has to explicitly set `ip_restriction` to empty slice (`[]`) to remove it.
- `scm_ip_restriction`                - (Optional) A list of `scm_ip_restriction` objects representing SCM IP restrictions as defined below.
  - `ip_address`                - (Optional) The IP Address used for this IP Restriction in CIDR notation.
  - `description`               - (Optional) The Description of this IP Restriction.
  - `service_tag`               - (Optional) The Service Tag used for this IP Restriction.
  - `virtual_network_subnet_id` - (Optional) The Virtual Network Subnet ID used for this IP Restriction.
  > Note: One of either `ip_address`, `service_tag` or `virtual_network_subnet_id` must be specified.
  - `name`                      - (Optional) The name for this IP Restriction.
  - `priority`                  - (Optional) The priority for this IP Restriction. Restrictions are enforced in priority order. By default, the priority is set to `65000` if not specified.
  - `action`                    - (Optional) Does this restriction `Allow` or `Deny` access for this IP range. Defaults to `Allow`.
  - `headers`                   - (Optional) The headers block for this specific `ip_restriction` as defined below.
    - `x_azure_fdid`      - (Optional) A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.
    - `x_fd_health_probe` - (Optional) A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".
    - `x_forwarded_for`   - (Optional) A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8.
    - `x_forwarded_host`  - (Optional) A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.
> Note: User has to explicitly set `scm_ip_restriction` to empty slice (`[]`) to remove it.
- `scm_use_main_ip_restriction`       - (Optional) Should the Logic App `ip_restriction` configuration be used for the SCM too. Defaults to `false`.
- `scm_min_tls_version`               - (Optional) Configures the minimum version of TLS required for SSL requests to the SCM site. Possible values are `1.0`, `1.1` and `1.2`.
- `scm_type`                          - (Optional) The type of Source Control used by the Logic App in use by the Windows Function App. Defaults to None. Possible values are: `BitbucketGit`, `BitbucketHg`, `CodePlexGit`, `CodePlexHg`, `Dropbox`, `ExternalGit`, `ExternalHg`, `GitHub`, `LocalGit`, `None`, `OneDrive`, `Tfs`, `VSO`, and `VSTSRM`.
- `linux_fx_version`                  - (Optional) Linux App Framework and version for the AppService, e.g. `DOCKER|(golang:latest)`. Setting this value will also set the `kind` of application deployed to `functionapp,linux,container,workflowapp`.
- `min_tls_version`                   - (Optional) The minimum supported TLS version for the Logic App Possible values are `1.0`, `1.1`, and `1.2`. Defaults to `1.2` for new Logic Apps.
- `pre_warmed_instance_count`         - (Optional) The number of pre-warmed instances for this Logic App Only affects apps on the Premium plan.
- `runtime_scale_monitoring_enabled`  - (Optional) Should Runtime Scale Monitoring be enabled?. Only applicable to apps on the Premium plan. Defaults to `false`.
- `use_32_bit_worker_process`         - (Optional) Should the Logic App run in 32 bit mode, rather than 64 bit mode? Defaults to `true`.
> Note: When using an App Service Plan in the `Free` or `Shared` Tiers `use_32_bit_worker_process` must be set to `true`.
- `vnet_route_all_enabled`            - (Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied.
- `websockets_enabled`                - (Optional) Should WebSockets be enabled?
DESCRIPTION
}

variable "storage_account_share_name" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The name of the share used by the logic app, if you want to use a custom name. This corresponds to the WEBSITE_CONTENTSHARE appsetting, which this resource will create for you. If you don't specify a name, then this resource will generate a dynamic name. This setting is useful if you want to provision a storage account and create a share using `azurerm_storage_share`.
> Note: When integrating a `CI/CD pipeline` and expecting to run from a deployed package in Azure you must seed your `app settings` as part of terraform code for Logic App to be successfully deployed. `Important Default key pairs: ("WEBSITE_RUN_FROM_PACKAGE" = "", "FUNCTIONS_WORKER_RUNTIME" = "node" (or Python, etc.), "WEBSITE_NODE_DEFAULT_VERSION" = "10.14.1", "APPINSIGHTS_INSTRUMENTATIONKEY" = "")`.
> Note: When using an App Service Plan in the `Free` or `Shared` Tiers `use_32_bit_worker_process` must be set to `true`.
DESCRIPTION
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "use_extension_bundle" {
  type        = bool
  default     = true
  description = "Should the logic app use the bundled extension package? If true, then application settings for `AzureFunctionsJobHost__extensionBundle__id` and `AzureFunctionsJobHost__extensionBundle__version` will be created."
}

variable "runtime_version" {
  type        = string
  default     = "~4"
  description = "The runtime version associated with the Logic App."
}

variable "virtual_network_subnet_id" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The subnet ID which will be used by this resource for [regional virtual network integration](https://docs.microsoft.com/en-us/azure/app-service/overview-vnet-integration#regional-virtual-network-integration).
> Note: The AzureRM Terraform provider provides regional virtual network integration via the standalone resource [app_service_virtual_network_swift_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) and in-line within this resource using the `virtual_network_subnet_id` property. You cannot use both methods simultaneously.
> Note: Assigning the `virtual_network_subnet_id` property requires [RBAC permissions on the subnet](https://docs.microsoft.com/en-us/azure/app-service/overview-vnet-integration#permissions).
DESCRIPTION
}

variable "vnet_content_share_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether allow routing traffic between the Logic App and Storage Account content share through a virtual network."
}
