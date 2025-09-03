resource "azurerm_resource_group" "azurerm_rg" {
  name     = "${var.location_cli}-${var.environment}-${var.workload}-${var.department}-rg-am"
  location = var.location_cli
}
