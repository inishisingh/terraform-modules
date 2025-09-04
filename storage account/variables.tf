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

variable "resource_group_name" {
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account"
  type        = string
  default     = "LRS"
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage and General Purpose v2 accounts (Hot or Cool)"
  type        = string
  default     = "Hot"
}
