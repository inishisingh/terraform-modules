# Azure Action Group Module

This Terraform module creates an Azure Monitor Action Group with support for email, SMS, and webhook receivers.

## Inputs

- `name`: Name of the Action Group
- `resource_group_name`: Name of the resource group
- `short_name`: Short name for the Action Group
- `location`: Azure region
- `email_receivers`: Map of email receiver names to email addresses
- `sms_receivers`: Map of SMS receiver names to objects with `country_code` and `phone_number`
- `webhook_receivers`: Map of webhook receiver names to service URIs

## Outputs

- `action_group_id`: The ID of the Action Group