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
        - name (required)
        - resource_group_name (optional)
        - subscription_id (optional)
        - type (required)
    - enrichment (block):
        - endpoint_names (required)
        - key (required)
        - value (required)
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
        - enabled (required)
        - endpoint_names (required)
        - name (required)
        - source (required)
EOT

  type = map(object({
    location                      = string
    name                          = string
    resource_group_name           = string
    event_hub_partition_count     = optional(number) # Default: 4
    event_hub_retention_in_days   = optional(number) # Default: 1
    local_authentication_enabled  = optional(bool)   # Default: true
    min_tls_version               = optional(string)
    public_network_access_enabled = optional(bool)
    tags                          = optional(map(string))
    sku = object({
      capacity = number
      name     = string
    })
    cloud_to_device = optional(object({
      default_ttl = optional(string) # Default: "PT1H"
      feedback = optional(object({
        lock_duration      = optional(string) # Default: "PT60S"
        max_delivery_count = optional(number) # Default: 10
        time_to_live       = optional(string) # Default: "PT1H"
      }))
      max_delivery_count = optional(number) # Default: 10
    }))
    endpoint = optional(object({
      authentication_type        = optional(string) # Default: "keyBased"
      batch_frequency_in_seconds = optional(number) # Default: 300
      connection_string          = optional(string)
      container_name             = optional(string)
      encoding                   = optional(string) # Default: "Avro"
      endpoint_uri               = optional(string)
      entity_path                = optional(string)
      file_name_format           = optional(string) # Default: "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}"
      identity_id                = optional(string)
      max_chunk_size_in_bytes    = optional(number) # Default: 314572800
      name                       = string
      resource_group_name        = optional(string)
      subscription_id            = optional(string)
      type                       = string
    }))
    enrichment = optional(list(object({
      endpoint_names = list(string)
      key            = string
      value          = string
    })))
    fallback_route = optional(object({
      condition      = optional(string) # Default: "true"
      enabled        = optional(bool)   # Default: true
      endpoint_names = optional(list(string))
      source         = optional(string) # Default: "DeviceMessages"
    }))
    file_upload = optional(object({
      authentication_type = optional(string) # Default: "keyBased"
      connection_string   = string
      container_name      = string
      default_ttl         = optional(string) # Default: "PT1H"
      identity_id         = optional(string)
      lock_duration       = optional(string) # Default: "PT1M"
      max_delivery_count  = optional(number) # Default: 10
      notifications       = optional(bool)   # Default: false
      sas_ttl             = optional(string) # Default: "PT1H"
    }))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
    network_rule_set = optional(object({
      apply_to_builtin_eventhub_endpoint = optional(bool)   # Default: false
      default_action                     = optional(string) # Default: "Deny"
      ip_rule = optional(object({
        action  = optional(string) # Default: "Allow"
        ip_mask = string
        name    = string
      }))
    }))
    route = optional(object({
      condition      = optional(string) # Default: "true"
      enabled        = bool
      endpoint_names = list(string)
      name           = string
      source         = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.enrichment == null || (length(v.enrichment) <= 10)
      )
    ])
    error_message = "Each enrichment list must contain at most 10 items"
  }
}

