
# monitoring-policy-windows (Azure Policy → AMA + DCR association by tag)

Installs **AzureMonitorWindowsAgent** and associates to a **DCR** for Windows VMs when the VM has the tag `monitor` with value in `[on, true, yes]`.

## Inputs
- `policy_assignment_scope_id` — assignment scope (subscription/RG/MG)
- `dcr_resource_id` — target DCR resource id
- `tag_key` — tag name (default `monitor`)
- `monitoring_tag_values` — allowed values (default `["on","true","yes"]`)

## Outputs
- `policy_assignment_id`
