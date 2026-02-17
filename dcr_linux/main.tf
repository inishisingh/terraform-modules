
resource "azurerm_monitor_data_collection_rule" "this" {
  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.location_cli
  description                 = var.description
  kind                        = "Linux"
  data_collection_endpoint_id = var.data_collection_endpoint_id

  dynamic "data_sources" {
    for_each = length(var.performance_counters) > 0 || length(var.syslog) > 0 || length(var.log_files) > 0 || length(var.extensions) > 0 ? [1] : []
    content {
      dynamic "performance_counter" {
        for_each = var.performance_counters
        content {
          name                          = performance_counter.value.name
          streams                       = performance_counter.value.streams
          sampling_frequency_in_seconds = performance_counter.value.sampling_frequency_in_seconds
          counter_specifiers            = performance_counter.value.counter_specifiers
        }
      }

      dynamic "syslog" {
        for_each = var.syslog
        content {
          name           = syslog.value.name
          streams        = syslog.value.streams
          facility_names = syslog.value.facility_names
          log_levels     = syslog.value.log_levels
        }
      }

      dynamic "log_file" {
        for_each = var.log_files
        content {
          name          = log_file.value.name
          streams       = log_file.value.streams
          file_patterns = log_file.value.file_patterns
          format        = log_file.value.format
          dynamic "settings" {
            for_each = try([log_file.value.settings], [])
            content {
              text {
                record_start_timestamp_format = settings.value.record_start_timestamp_format
              }
            }
          }
        }
      }

      dynamic "extension" {
        for_each = var.extensions
        content {
          name           = extension.value.name
          streams        = extension.value.streams
          extension_name = extension.value.extension_name
          extension_json = extension.value.extension_json
        }
      }
    }
  }

  destinations {
    log_analytics {
      name                  = var.law_destination_name
      workspace_resource_id = var.workspace_resource_id
    }

    dynamic "azure_monitor_metrics" {
      for_each = var.enable_azure_monitor_metrics ? [1] : []
      content { name = var.azure_monitor_metrics_name }
    }

    dynamic "event_hub" {
      for_each = var.event_hub_destinations
      content {
        name         = event_hub.value.name
        event_hub_id = event_hub.value.event_hub_id
      }
    }

    dynamic "storage_blob" {
      for_each = var.storage_blob_destinations
      content {
        name               = storage_blob.value.name
        storage_account_id = storage_blob.value.storage_account_id
        container_name     = storage_blob.value.container_name
      }
    }
  }

  dynamic "data_flow" {
    for_each = var.data_flows
    content {
      streams       = data_flow.value.streams
      destinations  = data_flow.value.destinations
      transform_kql = try(data_flow.value.transform_kql, null)
      output_stream = try(data_flow.value.output_stream, null)
    }
  }

  dynamic "stream_declaration" {
    for_each = var.stream_declarations
    content {
      stream_name = stream_declaration.value.stream_name
      dynamic "column" {
        for_each = stream_declaration.value.columns
        content {
          name = column.value.name
          type = column.value.type
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = var.tags
}
