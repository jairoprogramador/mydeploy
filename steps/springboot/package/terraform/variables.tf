variable "app_project_source_path" {
  description = "Define la ruta del directorio que contiene el código fuente de la aplicación"
  type        = string
}

variable "app_project_version" {
  description = "Define la versión semántica que se asignará como tag a la imagen Docker generada"
  type        = string
  default     = "latest"
}

variable "app_project_name" {
  description = "Define el nombre del proyecto que se utilizará para nombrar la imagen Docker"
  type        = string
}

variable "docker_dockerfile_path" {
  description = "Define la ruta del archivo Dockerfile utilizado para la construcción de la imagen"
  type        = string
}

variable "azure_resource_group_name" {
  description = "Define el nombre del Resource Group de Azure donde se encuentra alojado el Container Registry"
  type        = string
}

variable "azure_container_registry_name" {
  description = "Define el nombre del Azure Container Registry utilizado para almacenar las imágenes Docker"
  type        = string
}
