output "azure_subscription_id" {
  description = "Devuelve el ID de la suscripción de Azure utilizada para el despliegue"
  value = data.azurerm_client_config.current.subscription_id
}

output "azure_resource_group_name" {
  description = "Devuelve el nombre del grupo de recursos creado en Azure"
  value       = azurerm_resource_group.main.name
}

// este no se usa en el siguiente paso
output "azure_kubernetes_cluster_name" {
  description = "Devuelve el nombre del cluster de Azure Kubernetes Service (AKS) creado"
  value       = azurerm_kubernetes_cluster.main.name
}

output "azure_container_registry_name" {
  description = "Devuelve el nombre del Azure Container Registry (ACR) creado"
  value       = azurerm_container_registry.main.name
}

//ya no es necesario para el siguiente paso
output "azure_container_registry_login_server" {
  description = "Devuelve el dominio del servidor de inicio de sesión del Azure Container Registry"
  value       = azurerm_container_registry.main.login_server
}

output "azure_kubernetes_cluster_fqdn" {
  description = "Devuelve el nombre de dominio completamente calificado (FQDN) del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.fqdn
}