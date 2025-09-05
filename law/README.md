# Azure Log Analytics WorkSpace Module

This Terraform module creates an Azure Monitor Action Group with support for email, SMS, and webhook receivers.

## Inputs

- `name`: Name of the log analytics workspace
- `resource_group_name`: Name of the resource group
- `location`: Azure region

## Outputs

- `law_id`: The ID of the Action Group