output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.azurerm_sa.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.azurerm_sa.name
}

output "storage_account__conatiner_name" {
  description = "The name of the storage account conatiner"
  value       = azurerm_storage_container.azure_rm_conatiner.name
}

