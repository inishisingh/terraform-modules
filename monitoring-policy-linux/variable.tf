
variable "subscription_ids" {
  type = list(string)
}

variable "dcr_resource_id" {
  description = "Resource ID of the Data Collection Rule to associate VMs with."
  type        = string
}

variable "tag_key" {
  description = "Tag key used to include VMs in monitoring (embedded in policy condition)."
  type        = string
}

variable "monitoring_tag_values" {
  description = "Allowed values for the tag key to trigger onboarding."
  type        = list(string)
  default     = ["on", "true", "yes"]
}
