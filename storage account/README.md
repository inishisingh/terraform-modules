# Azure Storage Account Module

This Terraform module creates an Azure Storage Account with configurable options.

## Inputs

- `name`: The name of the storage account.
- `resource_group_name`: The name of the resource group.
- `location`: The Azure region.
- `account_tier`: Tier of the storage account (Standard or Premium).
- `account_replication_type`: Replication type (e.g., LRS, GRS).
- `access_tier`: Access tier (Hot or Cool).
- `tags`: Tags to apply to the storage account.

## Outputs

- `storage_account_id`: The ID of the storage account.
- `storage_account_name`: The name of the storage account.