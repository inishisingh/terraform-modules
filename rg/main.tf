resource "azurerm_resource_group" "this" {
  name     = "${var.client_name}-${var.environment}-${var.stack}-rg"
  location = var.location
}