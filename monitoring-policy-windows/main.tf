

terraform {
  required_version = ">= 1.4.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}


    locals {
      role_vm_contributor          = "/providers/Microsoft.Authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c"
      role_monitoring_contributor  = "/providers/Microsoft.Authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa"
      role_la_contributor          = "/providers/Microsoft.Authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"
    }

    resource "azurerm_policy_definition" "ama_by_tag" {
      name         = "Deploy-AMA-and-DCRA-Windows-By-Tag"
      display_name = "Deploy AMA + DCR Association for Windows VMs with tag"
      description  = "Installs Azure Monitor Agent on Windows VMs and associates them to a DCR when a tag matches allowed values"
      policy_type  = "Custom"
      mode         = "Indexed"

      metadata = jsonencode({ category = "Monitoring" })

      parameters = jsonencode({
        dcrResourceId = { type = "String", metadata = { displayName = "DCR Resource ID" } }
        monitoringTagValues = {
          type         = "Array"
          metadata     = { displayName = "Allowed values for the tag" }
          defaultValue = ["on","true","yes"]
        }
      })

      policy_rule = jsonencode({
        if = {
          allOf = [
            { field = "type", equals = "Microsoft.Compute/virtualMachines" },
            { field = "Microsoft.Compute/virtualMachines/storageProfile/osDisk/osType", equals = "Windows" },
            { field = format("tags['%s']", var.tag_key), "in" = "[parameters('monitoringTagValues')]" }
          ]
        }
        then = {
          effect = "DeployIfNotExists"
          details = {
            type              = "Microsoft.Insights/dataCollectionRuleAssociations"
            roleDefinitionIds = [
              local.role_vm_contributor,
              local.role_monitoring_contributor,
              local.role_la_contributor
            ]
            existenceCondition = {
              allOf = [
                { field = "Microsoft.Insights/dataCollectionRuleAssociations/dataCollectionRuleId", equals = "[parameters('dcrResourceId')]" }
              ]
            }
            deployment = {
              properties = {
                mode = "Incremental"
                template = {
                  "$schema"      : "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                  "contentVersion": "1.0.0.0",
                  "parameters"   : {
                    "vmName"  : { "type": "string" },
                    "location": { "type": "string" },
                    "dcrId"   : { "type": "string" }
                  },
                  "variables": {
                    "amaExtName": "AzureMonitorWindowsAgent"
                  },
                  "resources": [
                    {
                      "type": "Microsoft.Compute/virtualMachines/extensions",
                      "name": "[concat(parameters('vmName'), '/', variables('amaExtName'))]",
                      "apiVersion": "2022-11-01",
                      "location": "[parameters('location')]",
                      "properties": {
                        "publisher": "Microsoft.Azure.Monitor",
                        "type": "AzureMonitorWindowsAgent",
                        "typeHandlerVersion": "1.0",
                        "autoUpgradeMinorVersion": true,
                        "enableAutomaticUpgrade": true
                      }
                    },
                    {
                      "type": "Microsoft.Compute/virtualMachines/providers/dataCollectionRuleAssociations",
                      "name": "[concat(parameters('vmName'), '/Microsoft.Insights/', 'dcr-association')]",
                      "apiVersion": "2021-09-01-preview",
                      "location": "[parameters('location')]",
                      "properties": {
                        "description": "Associate VM to DCR via policy",
                        "dataCollectionRuleId": "[parameters('dcrId')]"
                      },
                      "dependsOn": [
                        "[resourceId('Microsoft.Compute/virtualMachines/extensions', parameters('vmName'), variables('amaExtName'))]"
                      ]
                    }
                  ],
                  "outputs": {}
                },
                parameters = {
                  vmName   = { value = "[field('name')]" },
                  location = { value = "[field('location')]" },
                  dcrId    = { value = "[parameters('dcrResourceId')]" }
                }
              }
            }
          }
        }
      })
    }

    resource "azurerm_policy_assignment" "assign" {
      name                 = "assign-ama-dcra-windows-by-tag"
      display_name         = "Assign AMA + DCR (Windows) when tag present"
      scope                = var.policy_assignment_scope_id
      policy_definition_id = azurerm_policy_definition.ama_by_tag.id

      identity { type = "SystemAssigned" }

      parameters = jsonencode({
        dcrResourceId       = { value = var.dcr_resource_id },
        monitoringTagValues = { value = var.monitoring_tag_values }
      })
    }

    resource "azurerm_role_assignment" "pa_vm_contrib" {
      scope              = var.policy_assignment_scope_id
      role_definition_id = local.role_vm_contributor
      principal_id       = azurerm_policy_assignment.assign.identity[0].principal_id
    }
    resource "azurerm_role_assignment" "pa_mon_contrib" {
      scope              = var.policy_assignment_scope_id
      role_definition_id = local.role_monitoring_contributor
      principal_id       = azurerm_policy_assignment.assign.identity[0].principal_id
    }
    resource "azurerm_role_assignment" "pa_la_contrib" {
      scope              = var.policy_assignment_scope_id
      role_definition_id = local.role_la_contributor
      principal_id       = azurerm_policy_assignment.assign.identity[0].principal_id
    }
