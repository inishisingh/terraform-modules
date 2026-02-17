
variable "policy_assignment_scope_id" {
  description = "Scope where the policy will be assigned (subscription/RG/MG)."
  type        = string
}

variable "dcr_resource_id" {
  description = "Resource ID of the Data Collection Rule to associate VMs with."
  type        = string
}

variable "tag_key" {
  description = "Tag key used to include VMs in monitoring (embedded in policy condition)."
  type        = string
  default     = "monitor"
}

variable "monitoring_tag_values" {
  description = "Allowed values for the tag key to trigger onboarding."
  type        = list(string)
  default     = ["on", "true", "yes"]
}
