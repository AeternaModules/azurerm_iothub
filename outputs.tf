output "iothubs" {
  description = "All iothub resources"
  value       = azurerm_iothub.iothubs
  sensitive   = true
}
output "iothubs_cloud_to_device" {
  description = "List of cloud_to_device values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.cloud_to_device]
}
output "iothubs_endpoint" {
  description = "List of endpoint values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.endpoint]
}
output "iothubs_enrichment" {
  description = "List of enrichment values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.enrichment]
}
output "iothubs_event_hub_events_endpoint" {
  description = "List of event_hub_events_endpoint values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.event_hub_events_endpoint]
}
output "iothubs_event_hub_events_namespace" {
  description = "List of event_hub_events_namespace values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.event_hub_events_namespace]
}
output "iothubs_event_hub_events_path" {
  description = "List of event_hub_events_path values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.event_hub_events_path]
}
output "iothubs_event_hub_operations_endpoint" {
  description = "List of event_hub_operations_endpoint values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.event_hub_operations_endpoint]
}
output "iothubs_event_hub_operations_path" {
  description = "List of event_hub_operations_path values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.event_hub_operations_path]
}
output "iothubs_event_hub_partition_count" {
  description = "List of event_hub_partition_count values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.event_hub_partition_count]
}
output "iothubs_event_hub_retention_in_days" {
  description = "List of event_hub_retention_in_days values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.event_hub_retention_in_days]
}
output "iothubs_fallback_route" {
  description = "List of fallback_route values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.fallback_route]
}
output "iothubs_file_upload" {
  description = "List of file_upload values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.file_upload]
  sensitive   = true
}
output "iothubs_hostname" {
  description = "List of hostname values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.hostname]
}
output "iothubs_identity" {
  description = "List of identity values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.identity]
}
output "iothubs_local_authentication_enabled" {
  description = "List of local_authentication_enabled values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.local_authentication_enabled]
}
output "iothubs_location" {
  description = "List of location values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.location]
}
output "iothubs_min_tls_version" {
  description = "List of min_tls_version values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.min_tls_version]
}
output "iothubs_name" {
  description = "List of name values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.name]
}
output "iothubs_network_rule_set" {
  description = "List of network_rule_set values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.network_rule_set]
}
output "iothubs_public_network_access_enabled" {
  description = "List of public_network_access_enabled values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.public_network_access_enabled]
}
output "iothubs_resource_group_name" {
  description = "List of resource_group_name values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.resource_group_name]
}
output "iothubs_route" {
  description = "List of route values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.route]
}
output "iothubs_shared_access_policy" {
  description = "List of shared_access_policy values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.shared_access_policy]
}
output "iothubs_sku" {
  description = "List of sku values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.sku]
}
output "iothubs_tags" {
  description = "List of tags values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.tags]
}
output "iothubs_type" {
  description = "List of type values across all iothubs"
  value       = [for k, v in azurerm_iothub.iothubs : v.type]
}

