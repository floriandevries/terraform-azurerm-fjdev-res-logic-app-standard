resource "azurerm_logic_app_standard" "logic" {
  app_service_plan_id                      = var.app_service_plan_id
  location                                 = var.location
  name                                     = var.name
  resource_group_name                      = var.resource_group_name
  storage_account_access_key               = var.storage_account_access_key
  storage_account_name                     = var.storage_account_name
  app_settings                             = var.app_settings
  bundle_version                           = var.bundle_version
  client_affinity_enabled                  = var.client_affinity_enabled
  client_certificate_mode                  = var.client_certificate_mode
  enabled                                  = var.enabled
  ftp_publish_basic_authentication_enabled = var.ftp_publish_basic_authentication_enabled
  https_only                               = var.https_only
  public_network_access                    = var.public_network_access
  scm_publish_basic_authentication_enabled = var.scm_publish_basic_authentication_enabled
  storage_account_share_name               = var.storage_account_share_name
  tags                                     = var.tags
  use_extension_bundle                     = var.use_extension_bundle
  version                                  = var.runtime_version
  virtual_network_subnet_id                = var.virtual_network_subnet_id
  vnet_content_share_enabled               = var.vnet_content_share_enabled

  dynamic "connection_string" {
    for_each = var.connection_string != null ? [var.connection_string] : []

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  dynamic "site_config" {
    for_each = var.site_config != null ? [var.site_config] : []

    content {
      always_on                        = site_config.value.always_on
      app_scale_limit                  = site_config.value.app_scale_limit
      auto_swap_slot_name              = site_config.value.auto_swap_slot_name
      dotnet_framework_version         = site_config.value.dotnet_framework_version
      elastic_instance_minimum         = site_config.value.elastic_instance_minimum
      ftps_state                       = site_config.value.ftps_state
      health_check_path                = site_config.value.health_check_path
      http2_enabled                    = site_config.value.http2_enabled
      linux_fx_version                 = site_config.value.linux_fx_version
      min_tls_version                  = site_config.value.min_tls_version
      pre_warmed_instance_count        = site_config.value.pre_warmed_instance_count
      runtime_scale_monitoring_enabled = site_config.value.runtime_scale_monitoring_enabled
      scm_min_tls_version              = site_config.value.scm_min_tls_version
      scm_type                         = site_config.value.scm_type
      scm_use_main_ip_restriction      = site_config.value.scm_use_main_ip_restriction
      use_32_bit_worker_process        = site_config.value.use_32_bit_worker_process
      vnet_route_all_enabled           = site_config.value.vnet_route_all_enabled
      websockets_enabled               = site_config.value.websockets_enabled

      dynamic "cors" {
        for_each = site_config.value.cors != null ? [site_config.value.cors] : []

        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = cors.value.support_credentials
        }
      }
      dynamic "ip_restriction" {
        for_each = site_config.value.ip_restriction

        content {
          action                    = ip_restriction.value.action
          description               = ip_restriction.value.description
          ip_address                = ip_restriction.value.ip_address
          name                      = ip_restriction.value.name
          priority                  = ip_restriction.value.priority
          service_tag               = ip_restriction.value.service_tag
          virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id

          dynamic "headers" {
            for_each = ip_restriction.value.headers != null ? [ip_restriction.value.headers] : []

            content {
              x_azure_fdid      = headers.value.x_azure_fdid
              x_fd_health_probe = headers.value.x_fd_health_probe
              x_forwarded_for   = headers.value.x_forwarded_for
              x_forwarded_host  = headers.value.x_forwarded_host
            }
          }
        }
      }
      dynamic "scm_ip_restriction" {
        for_each = site_config.value.scm_ip_restriction

        content {
          action                    = scm_ip_restriction.value.action
          description               = scm_ip_restriction.value.description
          ip_address                = scm_ip_restriction.value.ip_address
          name                      = scm_ip_restriction.value.name
          priority                  = scm_ip_restriction.value.priority
          service_tag               = scm_ip_restriction.value.service_tag
          virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id

          dynamic "headers" {
            for_each = scm_ip_restriction.value.headers != null ? [scm_ip_restriction.value.headers] : []

            content {
              x_azure_fdid      = headers.value.x_azure_fdid
              x_fd_health_probe = headers.value.x_fd_health_probe
              x_forwarded_for   = headers.value.x_forwarded_for
              x_forwarded_host  = headers.value.x_forwarded_host
            }
          }
        }
      }
    }
  }
}