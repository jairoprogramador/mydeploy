#import {
#  to = azurerm_resource_group.this
#  id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
#}

resource "random_id" "random_rg_name" {
  keepers = {
    value = var.resource_group_name
  }
  byte_length = 4
}

resource "random_id" "random_cr_name" {
  keepers = {
    value = var.container_registry_name
  }
  byte_length = 8
}

resource "random_id" "random_kc_name" {
  keepers = {
    value = var.kubernetes_cluster_name
  }
  byte_length = 4
}

resource "random_id" "random_dns_api_aks" {
  keepers = {
    value = var.dns_api_aks
  }
  byte_length = 4
}

resource "random_id" "random_ad_name" {
  keepers = {
    value = var.ad_display_name
  }
  byte_length = 4
}

resource "azurerm_resource_group" "this" {
  name     = "${var.resource_group_name}${local.suffixes.rg}"
  #name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.container_registry_name}${local.suffixes.cr}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku = "Basic"
  admin_enabled = false
}

resource "azuread_group" "aks_admins" {
  display_name     = "${var.ad_display_name}${local.suffixes.ad}"
  security_enabled = true
  members = [
    data.azuread_client_config.current.object_id
  ]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.kubernetes_cluster_name}${local.suffixes.kc}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "${var.dns_api_aks}${local.suffixes.dns}"

  node_resource_group = "${azurerm_resource_group.this.name}MC"

  default_node_pool {
    name       = "default"
    node_count = var.kubernetes_cluster_node_count
    vm_size    = var.kubernetes_cluster_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  local_account_disabled = true

  azure_active_directory_role_based_access_control {
    tenant_id = data.azuread_client_config.current.tenant_id
    azure_rbac_enabled = true
    admin_group_object_ids = [azuread_group.aks_admins.object_id]
  }

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_role_assignment" "acr_push" {
  #for_each             = toset(var.push_principal_ids)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
  principal_id         = data.azuread_client_config.current.object_id
}

resource "azurerm_role_assignment" "acr_pull" {
  #for_each             = toset(var.pull_principal_ids)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = data.azuread_client_config.current.object_id
}

resource "azurerm_role_assignment" "aks_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
