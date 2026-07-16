output "iothubs_id" {
  description = "Map of id values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.id if v.id != null && length(v.id) > 0 }
}
output "iothubs_cloud_to_device" {
  description = "Map of cloud_to_device values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.cloud_to_device if v.cloud_to_device != null && length(v.cloud_to_device) > 0 }
}
output "iothubs_endpoint" {
  description = "Map of endpoint values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.endpoint if v.endpoint != null && length(v.endpoint) > 0 }
}
output "iothubs_enrichment" {
  description = "Map of enrichment values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.enrichment if v.enrichment != null && length(v.enrichment) > 0 }
}
output "iothubs_event_hub_events_endpoint" {
  description = "Map of event_hub_events_endpoint values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_events_endpoint if v.event_hub_events_endpoint != null && length(v.event_hub_events_endpoint) > 0 }
}
output "iothubs_event_hub_events_namespace" {
  description = "Map of event_hub_events_namespace values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_events_namespace if v.event_hub_events_namespace != null && length(v.event_hub_events_namespace) > 0 }
}
output "iothubs_event_hub_events_path" {
  description = "Map of event_hub_events_path values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_events_path if v.event_hub_events_path != null && length(v.event_hub_events_path) > 0 }
}
output "iothubs_event_hub_operations_endpoint" {
  description = "Map of event_hub_operations_endpoint values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_operations_endpoint if v.event_hub_operations_endpoint != null && length(v.event_hub_operations_endpoint) > 0 }
}
output "iothubs_event_hub_operations_path" {
  description = "Map of event_hub_operations_path values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_operations_path if v.event_hub_operations_path != null && length(v.event_hub_operations_path) > 0 }
}
output "iothubs_event_hub_partition_count" {
  description = "Map of event_hub_partition_count values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_partition_count if v.event_hub_partition_count != null }
}
output "iothubs_event_hub_retention_in_days" {
  description = "Map of event_hub_retention_in_days values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_retention_in_days if v.event_hub_retention_in_days != null }
}
output "iothubs_fallback_route" {
  description = "Map of fallback_route values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.fallback_route if v.fallback_route != null && length(v.fallback_route) > 0 }
}
output "iothubs_file_upload" {
  description = "Map of file_upload values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.file_upload if v.file_upload != null && length(v.file_upload) > 0 }
  sensitive   = true
}
output "iothubs_hostname" {
  description = "Map of hostname values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.hostname if v.hostname != null && length(v.hostname) > 0 }
}
output "iothubs_identity" {
  description = "Map of identity values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.identity if v.identity != null && length(v.identity) > 0 }
}
output "iothubs_local_authentication_enabled" {
  description = "Map of local_authentication_enabled values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.local_authentication_enabled if v.local_authentication_enabled != null }
}
output "iothubs_location" {
  description = "Map of location values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.location if v.location != null && length(v.location) > 0 }
}
output "iothubs_min_tls_version" {
  description = "Map of min_tls_version values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.min_tls_version if v.min_tls_version != null && length(v.min_tls_version) > 0 }
}
output "iothubs_name" {
  description = "Map of name values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.name if v.name != null && length(v.name) > 0 }
}
output "iothubs_network_rule_set" {
  description = "Map of network_rule_set values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.network_rule_set if v.network_rule_set != null && length(v.network_rule_set) > 0 }
}
output "iothubs_public_network_access_enabled" {
  description = "Map of public_network_access_enabled values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.public_network_access_enabled if v.public_network_access_enabled != null }
}
output "iothubs_resource_group_name" {
  description = "Map of resource_group_name values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.resource_group_name if v.resource_group_name != null && length(v.resource_group_name) > 0 }
}
output "iothubs_route" {
  description = "Map of route values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.route if v.route != null && length(v.route) > 0 }
}
output "iothubs_shared_access_policy" {
  description = "Map of shared_access_policy values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.shared_access_policy if v.shared_access_policy != null && length(v.shared_access_policy) > 0 }
}
output "iothubs_sku" {
  description = "Map of sku values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.sku if v.sku != null && length(v.sku) > 0 }
}
output "iothubs_tags" {
  description = "Map of tags values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "iothubs_type" {
  description = "Map of type values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.type if v.type != null && length(v.type) > 0 }
}

