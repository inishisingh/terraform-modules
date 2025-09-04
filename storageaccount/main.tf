resource "azurerm_storage_account" "azurerm_sa" {
  name                     = "${var.environment}${var.workload}${var.department}saam"
  resource_group_name      = var.resource_group_name
  location                 = var.location_cli
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier
}

resource "azurerm_storage_container" "azure_rm_conatiner" {
  name                  = "statefile"
  storage_account_name    = azurerm_storage_account.azurerm_sa.name
  container_access_type = "private"
}
