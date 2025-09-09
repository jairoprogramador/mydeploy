output "resource_group_name" {
  description = "Resource Group donde se desplegó el ACR"
  value       = azurerm_resource_group.this.name
}

output "kubernetes_cluster_name" {
  description = "Kubernetes cluster creado"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "container_registry_name" {
  description = "Nombre del Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "container_registry_login_server" {
  description = "URL del servidor ACR"
  value       = azurerm_container_registry.acr.login_server
}