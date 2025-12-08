resource "azurerm_resource_group" "main" {
  name     = "${local.names.app_rm_acr_resource_group}"
  location = var.azure_location
  tags     = var.azure_resource_tags
}

resource "azurerm_container_registry" "main" {
  name                = "${local.names.app_rm_acr_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = var.azure_resource_tags
  
  lifecycle {
    ignore_changes = [name] 
  }
}