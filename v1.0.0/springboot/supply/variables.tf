variable "project" {
  default = {
    name = "mainrepository"
  }
}

variable "environment" {
  description = "Ambiente lógico (ej. platform, shared, cache)"
  type        = string
  default     = "cache"
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Nombre del Resource Group (si vacío, se crea uno)"
  type        = string
  default     = "fastdeployrgbdc385b2"
}

variable "container_registry_name" {
  description = "Nombre del Container Registry (si vacío, se crea uno)"
  type        = string
  default     = "fastdeploycr"
}

variable "tags" {
  description = "Etiquetas comunes"
  type        = map(string)
  default     = {}
}

variable "push_principal_ids" {
  description = "Object IDs (Entra ID) con rol AcrPush en el ACR (pipelines, identidades)"
  type        = list(string)
}

variable "pull_principal_ids" {
  description = "Object IDs con rol AcrPull en el ACR (AKS/VMSS/etc.)"
  type        = list(string)
}

variable "subscription_id" {
  description = "ID de la suscripción"
  type        = string
}
