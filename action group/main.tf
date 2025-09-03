resource "azurerm_monitor_action_group" "azurerm" {
  name     = "${var.location_cli}-${var.environment}-${var.workload}-${var.department}-ag-am"
  resource_group_name = var.resource_group_name
  short_name          = "${var.location_slug}${var.environment}agam"
  location            = var.location_cli

  dynamic "email_receiver" {
    for_each = var.email_receivers
    content {
      name                    = email_receiver.key
      email_address           = email_receiver.value
      use_common_alert_schema = true
    }
  }

  dynamic "webhook_receiver" {
    for_each = var.webhook_receivers
    content {
      name                    = webhook_receiver.key
      service_uri             = webhook_receiver.value
      use_common_alert_schema = true
    }
  }
}
