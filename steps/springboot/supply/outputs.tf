output "resource_group_name" {
  description = "Resource Group donde se desplegó el ACR"
  value       = azurerm_resource_group.this.name
}
