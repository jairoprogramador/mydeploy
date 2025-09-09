variable "project" {
  default = {
    name = "mainrepository"
  }
}

variable "environment" {
  description = "Ambiente lógico (ej. dev, test, prod)"
  type        = string
}

variable "project_source_path" {
  description = "Ruta del código fuente del proyecto Spring Boot"
  type        = string
  default     = "."
}

variable "project_version" {
  description = "Versión de despliegue para el tag de la imagen"
  type        = string
  default     = "latest"
}

variable "dockerfile_path" {
  description = "Ruta del Dockerfile"
  type        = string
}

variable "tags" {
  description = "Etiquetas comunes"
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  description = "ID de la suscripción"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group donde está el ACR"
  type        = string
}

variable "container_registry_name" {
  description = "Nombre del Container Registry"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para el tag de la imagen"
  type        = string
}
