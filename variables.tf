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
    min_tls_version               = optional(string) # Default: "1.2"
    public_network_access_enabled = optional(bool)
    tags                          = optional(map(string))
    sku = object({
      capacity = number
      name     = string
    })
    cloud_to_device = optional(object({
      default_ttl = optional(string) # Default: "PT1H"
      feedback = optional(list(object({
        lock_duration      = optional(string) # Default: "PT60S"
        max_delivery_count = optional(number) # Default: 10
        time_to_live       = optional(string) # Default: "PT1H"
      })))
      max_delivery_count = optional(number) # Default: 10
    }))
    endpoint = optional(list(object({
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
    })))
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
    network_rule_set = optional(list(object({
      apply_to_builtin_eventhub_endpoint = optional(bool)   # Default: false
      default_action                     = optional(string) # Default: "Deny"
      ip_rule = optional(list(object({
        action  = optional(string) # Default: "Allow"
        ip_mask = string
        name    = string
      })))
    })))
    route = optional(list(object({
      condition      = optional(string) # Default: "true"
      enabled        = bool
      endpoint_names = list(string)
      name           = string
      source         = string
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.iothubs : (
        v.enrichment == null || (length(v.enrichment) <= 10)
      )
    ])
    error_message = "Each enrichment list must contain at most 10 items"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_iothub's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    [from iothubValidate.IoTHubName] !matched
  # path: location
  #   source:    location.EnhancedValidate: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: resource_group_name
  #   condition: length(value) <= 90
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) > 90]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) > 90]
  # path: resource_group_name
  #   condition: !endswith(value, ".")
  #   message:   [from resourcegroups.ValidateName: must not end with "."]
  #   source:    [from resourcegroups.ValidateName: must not end with "."]
  # path: resource_group_name
  #   condition: length(value) != 0
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) == 0]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) == 0]
  # path: resource_group_name
  #   source:    [from resourcegroups.ValidateName] !matched
  # path: sku.name
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: sku.capacity
  #   condition: value >= 1 && value <= 200
  #   message:   must be between 1 and 200
  # path: event_hub_partition_count
  #   condition: value >= 2 && value <= 128
  #   message:   must be between 2 and 128
  # path: event_hub_retention_in_days
  #   condition: value >= 1 && value <= 7
  #   message:   must be between 1 and 7
  # path: file_upload.authentication_type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: file_upload.identity_id
  #   source:    [from commonids.ValidateUserAssignedIdentityID] !ok
  # path: file_upload.identity_id
  #   source:    [from commonids.ValidateUserAssignedIdentityID] err != nil
  # path: file_upload.max_delivery_count
  #   condition: value >= 1 && value <= 100
  #   message:   must be between 1 and 100
  # path: file_upload.sas_ttl
  #   source:    [from validate.ISO8601Duration] !ok
  # path: file_upload.sas_ttl
  #   source:    [from validate.ISO8601Duration] err != nil
  # path: file_upload.default_ttl
  #   source:    [from validate.ISO8601Duration] !ok
  # path: file_upload.default_ttl
  #   source:    [from validate.ISO8601Duration] err != nil
  # path: file_upload.lock_duration
  #   source:    [from validate.ISO8601Duration] !ok
  # path: file_upload.lock_duration
  #   source:    [from validate.ISO8601Duration] err != nil
  # path: endpoint.type
  #   condition: contains(["AzureIotHub.StorageContainer", "AzureIotHub.ServiceBusQueue", "AzureIotHub.ServiceBusTopic", "AzureIotHub.EventHub"], value)
  #   message:   must be one of: AzureIotHub.StorageContainer, AzureIotHub.ServiceBusQueue, AzureIotHub.ServiceBusTopic, AzureIotHub.EventHub
  # path: endpoint.authentication_type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: endpoint.identity_id
  #   source:    [from commonids.ValidateUserAssignedIdentityID] !ok
  # path: endpoint.identity_id
  #   source:    [from commonids.ValidateUserAssignedIdentityID] err != nil
  # path: endpoint.endpoint_uri
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: endpoint.entity_path
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: endpoint.name
  #   source:    [from iothubValidate.IoTHubEndpointName] name == value
  # path: endpoint.batch_frequency_in_seconds
  #   condition: value >= 60 && value <= 720
  #   message:   must be between 60 and 720
  # path: endpoint.max_chunk_size_in_bytes
  #   condition: value >= 10485760 && value <= 524288000
  #   message:   must be between 10485760 and 524288000
  # path: endpoint.encoding
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: endpoint.file_name_format
  #   source:    [from iothubValidate.FileNameFormat] !strings.Contains(value, component)
  # path: endpoint.resource_group_name
  #   condition: length(value) <= 90
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) > 90]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) > 90]
  # path: endpoint.resource_group_name
  #   condition: !endswith(value, ".")
  #   message:   [from resourcegroups.ValidateName: must not end with "."]
  #   source:    [from resourcegroups.ValidateName: must not end with "."]
  # path: endpoint.resource_group_name
  #   condition: length(value) != 0
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) == 0]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) == 0]
  # path: endpoint.resource_group_name
  #   source:    [from resourcegroups.ValidateName] !matched
  # path: endpoint.subscription_id
  #   condition: can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", value))
  #   message:   must be a valid UUID
  # path: route.name
  #   condition: can(regex("^[-_.a-zA-Z0-9]{1,64}$", value))
  #   message:   Route Name name can only include alphanumeric characters, periods, underscores, hyphens, has a maximum length of 64 characters, and must be unique.
  # path: route.source
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: enrichment.key
  #   condition: can(regex("^[-_.a-zA-Z0-9]{1,64}$", value))
  #   message:   Enrichment Key name can only include alphanumeric characters, periods, underscores, hyphens, has a maximum length of 64 characters, and must be unique.
  # path: enrichment.value
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: fallback_route.source
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: fallback_route.endpoint_names[*]
  #   condition: length(value) >= 0 && length(value) <= 64
  #   message:   must be between 0 and 64 characters
  # path: network_rule_set.default_action
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: network_rule_set.ip_rule.name
  #   source:    [from iothubValidate.IoTHubIpRuleName] !matched
  # path: network_rule_set.ip_rule.ip_mask
  #   source:    [from validate.CIDR] re != nil && !re.MatchString(cidr)
  # path: network_rule_set.ip_rule.action
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: cloud_to_device.max_delivery_count
  #   condition: value >= 1 && value <= 100
  #   message:   must be between 1 and 100
  # path: cloud_to_device.default_ttl
  #   source:    validate.ISO8601DurationBetween: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: cloud_to_device.feedback.time_to_live
  #   source:    validate.ISO8601DurationBetween: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: cloud_to_device.feedback.max_delivery_count
  #   condition: value >= 1 && value <= 100
  #   message:   must be between 1 and 100
  # path: cloud_to_device.feedback.lock_duration
  #   source:    validate.ISO8601DurationBetween: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: min_tls_version
  #   condition: contains(["1.2"], value)
  #   message:   must be one of: 1.2
  # path: identity.type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: identity.identity_ids[*]
  #   source:    [from commonids.ValidateUserAssignedIdentityID] !ok
  # path: identity.identity_ids[*]
  #   source:    [from commonids.ValidateUserAssignedIdentityID] err != nil
  # path: tags
  #   condition: length(value) <= 50
  #   message:   [from tags.Validate: invalid when len(value) > 50]
  #   source:    [from tags.Validate: invalid when len(value) > 50]
  # path: tags
  #   condition: length(value) <= 512
  #   message:   [from tags.Validate: invalid when len(value) > 512]
  #   source:    [from tags.Validate: invalid when len(value) > 512]
  # path: tags
  #   source:    [from tags.Validate] err != nil
  # path: tags
  #   condition: length(value) <= 256
  #   message:   [from tags.Validate: invalid when len(value) > 256]
  #   source:    [from tags.Validate: invalid when len(value) > 256]
}

