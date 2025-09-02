output "location" {
  description = "Full Azure region name"
  value       = local.region_map[var.azure_region].location
}

output "location_short" {
  description = "Short name for the region"
  value       = local.region_map[var.azure_region].location_short
}

output "location_slug" {
  description = "Slug format of the region"
  value       = local.region_map[var.azure_region].location_slug
}

output "location_cli" {
  description = "CLI format of the region"
  value       = local.region_map[var.azure_region].location_cli
}