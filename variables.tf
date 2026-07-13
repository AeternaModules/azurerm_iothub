variable "iothubs" {
  description = <<EOT
Map of iothubs, attributes below
Required:
    - location
    - name
    - resource_group_name
    - sku (block):
        - capacity (required)
        - name (required)
Optional:
    - event_hub_partition_count
    - event_hub_retention_in_days
    - local_authentication_enabled
    - min_tls_version
    - public_network_access_enabled
    - tags
    - cloud_to_device (block):
        - default_ttl (optional)
        - feedback (optional, block):
            - lock_duration (optional)
            - max_delivery_count (optional)
            - time_to_live (optional)
        - max_delivery_count (optional)
    - endpoint (block):
        - authentication_type (optional)
        - batch_frequency_in_seconds (optional)
        - connection_string (optional)
        - container_name (optional)
        - encoding (optional)
        - endpoint_uri (optional)
        - entity_path (optional)
        - file_name_format (optional)
        - identity_id (optional)
        - max_chunk_size_in_bytes (optional)
        - name (optional)
        - resource_group_name (optional)
        - subscription_id (optional)
        - type (optional)
    - enrichment (block):
        - endpoint_names (optional)
        - key (optional)
        - value (optional)
    - fallback_route (block):
        - condition (optional)
        - enabled (optional)
        - endpoint_names (optional)
        - source (optional)
    - file_upload (block):
        - authentication_type (optional)
        - connection_string (required)
        - container_name (required)
        - default_ttl (optional)
        - identity_id (optional)
        - lock_duration (optional)
        - max_delivery_count (optional)
        - notifications (optional)
        - sas_ttl (optional)
    - identity (block):
        - identity_ids (optional)
        - type (required)
    - network_rule_set (block):
        - apply_to_builtin_eventhub_endpoint (optional)
        - default_action (optional)
        - ip_rule (optional, block):
            - action (optional)
            - ip_mask (required)
            - name (required)
    - route (block):
        - condition (optional)
        - enabled (optional)
        - endpoint_names (optional)
        - name (optional)
        - source (optional)
EOT

  type = map(object({
    location                      = string
    name                          = string
    resource_group_name           = string
    event_hub_partition_count     = optional(number)
    event_hub_retention_in_days   = optional(number)
    local_authentication_enabled  = optional(bool)
    min_tls_version               = optional(string)
    public_network_access_enabled = optional(bool)
    tags                          = optional(map(string))
    sku = object({
      capacity = number
      name     = string
    })
    cloud_to_device = optional(object({
      default_ttl = optional(string)
      feedback = optional(list(object({
        lock_duration      = optional(string)
        max_delivery_count = optional(number)
        time_to_live       = optional(string)
      })))
      max_delivery_count = optional(number)
    }))
    endpoint = optional(list(object({
      authentication_type        = optional(string)
      batch_frequency_in_seconds = optional(number)
      connection_string          = optional(string)
      container_name             = optional(string)
      encoding                   = optional(string)
      endpoint_uri               = optional(string)
      entity_path                = optional(string)
      file_name_format           = optional(string)
      identity_id                = optional(string)
      max_chunk_size_in_bytes    = optional(number)
      name                       = optional(string)
      resource_group_name        = optional(string)
      subscription_id            = optional(string)
      type                       = optional(string)
    })))
    enrichment = optional(list(object({
      endpoint_names = optional(list(string))
      key            = optional(string)
      value          = optional(string)
    })))
    fallback_route = optional(object({
      condition      = optional(string)
      enabled        = optional(bool)
      endpoint_names = optional(list(string))
      source         = optional(string)
    }))
    file_upload = optional(object({
      authentication_type = optional(string)
      connection_string   = string
      container_name      = string
      default_ttl         = optional(string)
      identity_id         = optional(string)
      lock_duration       = optional(string)
      max_delivery_count  = optional(number)
      notifications       = optional(bool)
      sas_ttl             = optional(string)
    }))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
    network_rule_set = optional(list(object({
      apply_to_builtin_eventhub_endpoint = optional(bool)
      default_action                     = optional(string)
      ip_rule = optional(list(object({
        action  = optional(string)
        ip_mask = string
        name    = string
      })))
    })))
    route = optional(list(object({
      condition      = optional(string)
      enabled        = optional(bool)
      endpoint_names = optional(list(string))
      name           = optional(string)
      source         = optional(string)
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.sku.capacity >= 1 && v.sku.capacity <= 200
      )
    ])
    error_message = "must be between 1 and 200"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.event_hub_partition_count == null || (v.event_hub_partition_count >= 2 && v.event_hub_partition_count <= 128)
      )
    ])
    error_message = "must be between 2 and 128"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.event_hub_retention_in_days == null || (v.event_hub_retention_in_days >= 1 && v.event_hub_retention_in_days <= 7)
      )
    ])
    error_message = "must be between 1 and 7"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.file_upload == null || (v.file_upload.max_delivery_count == null || (v.file_upload.max_delivery_count >= 1 && v.file_upload.max_delivery_count <= 100))
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.endpoint == null || alltrue([for item in v.endpoint : (item.type == null || (contains(["AzureIotHub.StorageContainer", "AzureIotHub.ServiceBusQueue", "AzureIotHub.ServiceBusTopic", "AzureIotHub.EventHub"], item.type)))])
      )
    ])
    error_message = "must be one of: AzureIotHub.StorageContainer, AzureIotHub.ServiceBusQueue, AzureIotHub.ServiceBusTopic, AzureIotHub.EventHub"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.endpoint == null || alltrue([for item in v.endpoint : (item.endpoint_uri == null || (length(item.endpoint_uri) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.endpoint == null || alltrue([for item in v.endpoint : (item.batch_frequency_in_seconds == null || (item.batch_frequency_in_seconds >= 60 && item.batch_frequency_in_seconds <= 720))])
      )
    ])
    error_message = "must be between 60 and 720"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.endpoint == null || alltrue([for item in v.endpoint : (item.max_chunk_size_in_bytes == null || (item.max_chunk_size_in_bytes >= 10485760 && item.max_chunk_size_in_bytes <= 524288000))])
      )
    ])
    error_message = "must be between 10485760 and 524288000"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.endpoint == null || alltrue([for item in v.endpoint : (item.resource_group_name == null || (length(item.resource_group_name) <= 90))])
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.endpoint == null || alltrue([for item in v.endpoint : (item.resource_group_name == null || (!endswith(item.resource_group_name, ".")))])
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.endpoint == null || alltrue([for item in v.endpoint : (item.resource_group_name == null || (length(item.resource_group_name) != 0))])
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.endpoint == null || alltrue([for item in v.endpoint : (item.subscription_id == null || (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.subscription_id))))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.route == null || alltrue([for item in v.route : (item.name == null || (can(regex("^[-_.a-zA-Z0-9]{1,64}$", item.name))))])
      )
    ])
    error_message = "Route Name name can only include alphanumeric characters, periods, underscores, hyphens, has a maximum length of 64 characters, and must be unique."
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.enrichment == null || alltrue([for item in v.enrichment : (item.key == null || (can(regex("^[-_.a-zA-Z0-9]{1,64}$", item.key))))])
      )
    ])
    error_message = "Enrichment Key name can only include alphanumeric characters, periods, underscores, hyphens, has a maximum length of 64 characters, and must be unique."
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.enrichment == null || alltrue([for item in v.enrichment : (item.value == null || (length(item.value) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.fallback_route == null || (v.fallback_route.endpoint_names == null || (alltrue([for x in v.fallback_route.endpoint_names : length(x) >= 0 && length(x) <= 64])))
      )
    ])
    error_message = "must be between 0 and 64 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.cloud_to_device == null || (v.cloud_to_device.max_delivery_count == null || (v.cloud_to_device.max_delivery_count >= 1 && v.cloud_to_device.max_delivery_count <= 100))
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.cloud_to_device == null || (v.cloud_to_device.feedback == null || alltrue([for item in v.cloud_to_device.feedback : (item.max_delivery_count == null || (item.max_delivery_count >= 1 && item.max_delivery_count <= 100))]))
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.min_tls_version == null || (contains(["1.2"], v.min_tls_version))
      )
    ])
    error_message = "must be one of: 1.2"
  }
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.tags == null || (length(v.tags) <= 50)
      )
    ])
    error_message = "[from tags.Validate: invalid when len(value) > 50]"
  }
  # Note: 36 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

