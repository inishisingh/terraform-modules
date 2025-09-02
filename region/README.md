# Azure Region Module

This Terraform module standardizes Azure region naming formats.

## Input

- `azure_region`: Region name in CLI format (e.g., `eastus`, `westus`)

## Outputs

- `location`: Full region name (e.g., `East US`)
- `location_short`: Short name for naming conventions (e.g., `eus`)
- `location_slug`: Slug format (e.g., `east-us`)
- `location_cli`: CLI format (e.g., `eastus`)