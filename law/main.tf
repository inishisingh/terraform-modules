resource "azurerm_log_analytics_workspace" "azurerm_law" {
  name                = "${var.location_cli}-${var.environment}-${var.workload}-${var.department}-law-am"
  location            = var.location_cli
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}