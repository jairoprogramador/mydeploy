variable "project" {
  default = {
    name = "mainrepository"
  }
}

variable "environment" {
  description = "Ambiente lógico (ej. dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Nombre del Resource Group (si vacío, se crea uno)"
  type        = string
  default     = "fdrg"
}

variable "ad_display_name" {
  description = "Nombre del Active Directory Group (si vacío, se crea uno)"
  type        = string
  default     = "fdad"
}

variable "container_registry_name" {
  description = "Nombre del Container Registry (si vacío, se crea uno)"
  type        = string
  default     = "fdcr"
}

variable "kubernetes_cluster_name" {
  description = "Nombre del Kubernetes Cluster (si vacío, se crea uno)"
  type        = string
  default     = "fdkc"
}

variable "kubernetes_cluster_node_count" {
  description = "Cantidad de nodos de Kubernetes (por defecto 1)"
  type        = number
  default     = 1
}

variable "kubernetes_cluster_vm_size" {
  description = "Tamaño de la maquina virtual (por defecto standard_a2_v2)"
  type        = string
  default     = "standard_a2_v2"
}

variable "dns_api_aks" {
  description = "Prefijo DNS del Kubernetes Cluster"
  type        = string
  default     = "fdkcdns"
}

variable "tags" {
  description = "Etiquetas comunes"
  type        = map(string)
  default     = {}
}

/* variable "push_principal_ids" {
  description = "Object IDs (Entra ID) con rol AcrPush en el ACR (pipelines, identidades)"
  type        = list(string)
}

variable "pull_principal_ids" {
  description = "Object IDs con rol AcrPull en el ACR (AKS/VMSS/etc.)"
  type        = list(string)
} */

variable "subscription_id" {
  description = "ID de la suscripción"
  type        = string
}
