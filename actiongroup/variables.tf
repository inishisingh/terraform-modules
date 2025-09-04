variable "environment" {
  type = string
}

variable "workload" {
  type = string
}

variable "department" {
  type = string
}

variable "location_cli" {
  type = string
}

variable "location_slug" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "email_receivers" {
  type = map(string)
  description = "Map of email receiver names to email addresses"
}

variable "webhook_receivers" {
  type = map(string)
  description = "Map of webhook receiver names to service URIs"
}


