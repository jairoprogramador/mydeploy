resource "random_id" "resource_group_suffix" {
  keepers = {
    value = var.azure_resource_group_name
  }
  byte_length = 4
}

resource "random_id" "container_registry_suffix" {
  keepers = {
    value = var.azure_container_registry_name
  }
  byte_length = 8
}

resource "random_id" "kubernetes_cluster_suffix" {
  keepers = {
    value = var.azure_kubernetes_cluster_name
  }
  byte_length = 4
}

resource "random_id" "dns_prefix_suffix" {
  keepers = {
    value = var.azure_dns_prefix_aks
  }
  byte_length = 4
}

resource "random_id" "active_directory_suffix" {
  keepers = {
    value = var.azure_ad_display_name
  }
  byte_length = 4
}

resource "azurerm_resource_group" "main" {
  name     = "${var.azure_resource_group_name}${local.suffixes.resource_group}"
  location = var.azure_location
  tags     = local.common_tags
}

resource "azurerm_container_registry" "main" {
  name                = "${var.azure_container_registry_name}${local.suffixes.container_registry}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku = "Basic"
  admin_enabled = false
  tags = local.common_tags
}

resource "azuread_group" "aks_administrators" {
  display_name     = "${var.azure_ad_display_name}${local.suffixes.active_directory_display_name}"
  security_enabled = true
  members = [
    data.azuread_client_config.current.object_id
  ]
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.azure_kubernetes_cluster_name}${local.suffixes.kubernetes_cluster}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.azure_dns_prefix_aks}${local.suffixes.dns_prefix}"

  node_resource_group = "${azurerm_resource_group.main.name}nodes"

  default_node_pool {
    name       = "default"
    node_count = var.azure_kubernetes_cluster_node_count
    vm_size    = var.azure_kubernetes_cluster_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  local_account_disabled = true
  azure_policy_enabled = true

  azure_active_directory_role_based_access_control {
    tenant_id = data.azuread_client_config.current.tenant_id
    azure_rbac_enabled = true
    admin_group_object_ids = [azuread_group.aks_administrators.object_id]
  }

  tags = local.common_tags
}

resource "azurerm_role_assignment" "acr_push_permissions" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPush"
  principal_id         = data.azuread_client_config.current.object_id
}

resource "azurerm_role_assignment" "acr_pull_permissions" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = data.azuread_client_config.current.object_id
}

resource "azurerm_role_assignment" "aks_acr_pull_permissions" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main.id
}