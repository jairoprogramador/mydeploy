import {
  to = azurerm_resource_group.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
}

locals {
  rg_name = var.resource_group_name != "" ? var.resource_group_name : lower(replace("${var.project.name}-${var.environment}-${var.location}", " ", "-"))

  common_tags = merge({
    "project" : var.project.name,
    "environment" : var.environment,
    "managed-by" : "fastdeploy",
    "layer" : "platform",
    "component" : "acr-cache"
  }, var.tags)
}

resource "random_id" "random_rg_name" {
  keepers = {
    value = local.rg_name
  }
  byte_length = 4
}

resource "random_id" "random_cr_name" {
  keepers = {
    value = var.container_registry_name
  }
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  #name     = "${local.rg_name}${random_id.random_rg_name.hex}"
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.container_registry_name}${random_id.random_cr_name.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku = "Basic"
  admin_enabled = false
}

resource "azurerm_role_assignment" "acr_push" {
  for_each             = toset(var.push_principal_ids)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "acr_pull" {
  for_each             = toset(var.pull_principal_ids)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = each.value
}
