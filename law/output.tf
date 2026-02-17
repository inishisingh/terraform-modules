output "law_id" {
  description = "The ID of the Law (log Analytics Workspcace)"
  value       = azurerm_log_analytics_workspace.azurerm_law.id
}

output "law_name" {
  description = "The name of the Law (log Analytics Workspcace)"
  value       = azurerm_log_analytics_workspace.azurerm_law.name
}
