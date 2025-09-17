data "azurerm_client_config" "current" {}

data "azurerm_container_registry" "current" {
  name                = var.azure_container_registry_name
  resource_group_name = var.azure_resource_group_name
}
