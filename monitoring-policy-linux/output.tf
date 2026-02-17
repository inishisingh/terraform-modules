
output "policy_assignment_id" {
  value       = azurerm_policy_assignment.assign.id
  description = "Resource ID of the policy assignment"
}
