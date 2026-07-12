output "iothubs_id" {
  description = "Map of id values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.id }
}
output "iothubs_cloud_to_device" {
  description = "Map of cloud_to_device values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.cloud_to_device }
}
output "iothubs_endpoint" {
  description = "Map of endpoint values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.endpoint }
}
output "iothubs_enrichment" {
  description = "Map of enrichment values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.enrichment }
}
output "iothubs_event_hub_events_endpoint" {
  description = "Map of event_hub_events_endpoint values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_events_endpoint }
}
output "iothubs_event_hub_events_namespace" {
  description = "Map of event_hub_events_namespace values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_events_namespace }
}
output "iothubs_event_hub_events_path" {
  description = "Map of event_hub_events_path values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_events_path }
}
output "iothubs_event_hub_operations_endpoint" {
  description = "Map of event_hub_operations_endpoint values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_operations_endpoint }
}
output "iothubs_event_hub_operations_path" {
  description = "Map of event_hub_operations_path values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_operations_path }
}
output "iothubs_event_hub_partition_count" {
  description = "Map of event_hub_partition_count values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_partition_count }
}
output "iothubs_event_hub_retention_in_days" {
  description = "Map of event_hub_retention_in_days values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.event_hub_retention_in_days }
}
output "iothubs_fallback_route" {
  description = "Map of fallback_route values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.fallback_route }
}
output "iothubs_file_upload" {
  description = "Map of file_upload values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.file_upload }
  sensitive   = true
}
output "iothubs_hostname" {
  description = "Map of hostname values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.hostname }
}
output "iothubs_identity" {
  description = "Map of identity values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.identity }
}
output "iothubs_local_authentication_enabled" {
  description = "Map of local_authentication_enabled values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.local_authentication_enabled }
}
output "iothubs_location" {
  description = "Map of location values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.location }
}
output "iothubs_min_tls_version" {
  description = "Map of min_tls_version values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.min_tls_version }
}
output "iothubs_name" {
  description = "Map of name values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.name }
}
output "iothubs_network_rule_set" {
  description = "Map of network_rule_set values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.network_rule_set }
}
output "iothubs_public_network_access_enabled" {
  description = "Map of public_network_access_enabled values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.public_network_access_enabled }
}
output "iothubs_resource_group_name" {
  description = "Map of resource_group_name values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.resource_group_name }
}
output "iothubs_route" {
  description = "Map of route values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.route }
}
output "iothubs_shared_access_policy" {
  description = "Map of shared_access_policy values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.shared_access_policy }
}
output "iothubs_sku" {
  description = "Map of sku values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.sku }
}
output "iothubs_tags" {
  description = "Map of tags values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.tags }
}
output "iothubs_type" {
  description = "Map of type values across all iothubs, keyed the same as var.iothubs"
  value       = { for k, v in azurerm_iothub.iothubs : k => v.type }
}

