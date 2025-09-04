resource "azurerm_storage_account" "azurerm_sa" {
  name                     = "${var.environment}${var.workload}${var.department}saam"
  resource_group_name      = var.resource_group_name
  location                 = var.location_cli
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier
}
