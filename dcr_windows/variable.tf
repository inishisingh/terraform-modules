
variable "name"               { type = string }
variable "resource_group_name" { type = string }
variable "location"            { type = string }
variable "description"         { type = string  default = null }
variable "data_collection_endpoint_id" { type = string default = null }

# LAW destination
variable "law_destination_name"    { type = string default = "logs" }
variable "workspace_resource_id"   { type = string }

# Optional destinations
variable "enable_azure_monitor_metrics" { type = bool   default = false }
variable "azure_monitor_metrics_name"   { type = string default = "metrics" }
variable "event_hub_destinations" {
  type    = list(object({ name = string, event_hub_id = string }))
  default = []
}
variable "storage_blob_destinations" {
  type    = list(object({ name = string, storage_account_id = string, container_name = string }))
  default = []
}

# Data sources (Windows)
variable "performance_counters" {
  description = "Windows/Linux performance counters (e.g., \VmInsights\DetailedMetrics)."
  type = list(object({
    name                          = string
    streams                       = list(string)
    sampling_frequency_in_seconds = number
    counter_specifiers            = list(string)
  }))
  default = []
}

variable "windows_event_logs" {
  type = list(object({
    name           = string
    streams        = list(string)
    x_path_queries = list(string)
  }))
  default = []
}

variable "iis_logs" {
  type = list(object({
    name           = string
    streams        = list(string)
    log_directories = optional(list(string))
  }))
  default = []
}

variable "log_files" {
  type = list(object({
    name          = string
    streams       = list(string)
    file_patterns = list(string)
    format        = string # typically "text"
    settings      = optional(object({
      record_start_timestamp_format = string
    }))
  }))
  default = []
}

variable "extensions" {
  type = list(object({
    name           = string
    streams        = list(string)
    extension_name = string
    extension_json = string
  }))
  default = []
}

# Data flows & stream declarations
variable "data_flows" {
  type = list(object({
    streams       = list(string)
    destinations  = list(string)
    transform_kql = optional(string)
    output_stream = optional(string)
  }))
  default = []
}

variable "stream_declarations" {
  type = list(object({
    stream_name = string
    columns     = list(object({ name = string, type = string }))
  }))
  default = []
}

# Identity & tags
variable "identity_type" { type = string default = null } # "SystemAssigned" or "UserAssigned"
variable "identity_ids"  { type = list(string) default = [] }
variable "tags"          { type = map(string)  default = {} }
