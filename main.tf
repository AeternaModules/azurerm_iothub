resource "azurerm_iothub" "iothubs" {
  for_each = var.iothubs

  location                      = each.value.location
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  event_hub_partition_count     = each.value.event_hub_partition_count
  event_hub_retention_in_days   = each.value.event_hub_retention_in_days
  local_authentication_enabled  = each.value.local_authentication_enabled
  min_tls_version               = each.value.min_tls_version
  public_network_access_enabled = each.value.public_network_access_enabled
  tags                          = each.value.tags

  sku {
    capacity = each.value.sku.capacity
    name     = each.value.sku.name
  }

  dynamic "cloud_to_device" {
    for_each = each.value.cloud_to_device != null ? [each.value.cloud_to_device] : []
    content {
      default_ttl = cloud_to_device.value.default_ttl
      dynamic "feedback" {
        for_each = cloud_to_device.value.feedback != null ? [cloud_to_device.value.feedback] : []
        content {
          lock_duration      = feedback.value.lock_duration
          max_delivery_count = feedback.value.max_delivery_count
          time_to_live       = feedback.value.time_to_live
        }
      }
      max_delivery_count = cloud_to_device.value.max_delivery_count
    }
  }

  dynamic "endpoint" {
    for_each = each.value.endpoint != null ? [each.value.endpoint] : []
    content {
      authentication_type        = endpoint.value.authentication_type
      batch_frequency_in_seconds = endpoint.value.batch_frequency_in_seconds
      connection_string          = endpoint.value.connection_string
      container_name             = endpoint.value.container_name
      encoding                   = endpoint.value.encoding
      endpoint_uri               = endpoint.value.endpoint_uri
      entity_path                = endpoint.value.entity_path
      file_name_format           = endpoint.value.file_name_format
      identity_id                = endpoint.value.identity_id
      max_chunk_size_in_bytes    = endpoint.value.max_chunk_size_in_bytes
      name                       = endpoint.value.name
      resource_group_name        = endpoint.value.resource_group_name
      subscription_id            = endpoint.value.subscription_id
      type                       = endpoint.value.type
    }
  }

  dynamic "enrichment" {
    for_each = each.value.enrichment != null ? each.value.enrichment : []
    content {
      endpoint_names = enrichment.value.endpoint_names
      key            = enrichment.value.key
      value          = enrichment.value.value
    }
  }

  dynamic "fallback_route" {
    for_each = each.value.fallback_route != null ? [each.value.fallback_route] : []
    content {
      condition      = fallback_route.value.condition
      enabled        = fallback_route.value.enabled
      endpoint_names = fallback_route.value.endpoint_names
      source         = fallback_route.value.source
    }
  }

  dynamic "file_upload" {
    for_each = each.value.file_upload != null ? [each.value.file_upload] : []
    content {
      authentication_type = file_upload.value.authentication_type
      connection_string   = file_upload.value.connection_string
      container_name      = file_upload.value.container_name
      default_ttl         = file_upload.value.default_ttl
      identity_id         = file_upload.value.identity_id
      lock_duration       = file_upload.value.lock_duration
      max_delivery_count  = file_upload.value.max_delivery_count
      notifications       = file_upload.value.notifications
      sas_ttl             = file_upload.value.sas_ttl
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      identity_ids = identity.value.identity_ids
      type         = identity.value.type
    }
  }

  dynamic "network_rule_set" {
    for_each = each.value.network_rule_set != null ? [each.value.network_rule_set] : []
    content {
      apply_to_builtin_eventhub_endpoint = network_rule_set.value.apply_to_builtin_eventhub_endpoint
      default_action                     = network_rule_set.value.default_action
      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rule != null ? [network_rule_set.value.ip_rule] : []
        content {
          action  = ip_rule.value.action
          ip_mask = ip_rule.value.ip_mask
          name    = ip_rule.value.name
        }
      }
    }
  }

  dynamic "route" {
    for_each = each.value.route != null ? [each.value.route] : []
    content {
      condition      = route.value.condition
      enabled        = route.value.enabled
      endpoint_names = route.value.endpoint_names
      name           = route.value.name
      source         = route.value.source
    }
  }
}

