/*VARIABLES OBLIGATORIAS*/
variable "azure_subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
}

variable "app_environment" {
  description = "Define el entorno de despliegue (sand, stag, prod)"
  type        = string
}

variable "app_project_name" {
  description = "Define el nombre del proyecto"
  type = string
  validation {
    condition = length(var.app_project_name) > 0
    error_message = "El nombre del proyecto no puede estar vacío"
  }
}

variable "app_team_name" {
  description = "Define el nombre del equipo responsable del proyecto"
  type = string
  validation {
    condition = length(var.app_team_name) > 0
    error_message = "El nombre del equipo no puede estar vacío"
  }
}

/*VARIABLES OPCIONALES*/

variable "azure_resource_tags" {
  description = "Define las etiquetas comunes aplicadas a todos los recursos de Azure"
  type        = map(string)
  default     = {
    owner        = "sre-team@mycompany.com"
    cost_center  = "fastdeploy"
    compliance   = "RGPD is example"
    create_by    = "fastdeploy"
    lifecycle    = "ephemeral"
  }
}

variable "azure_location" {
  description = "Define la región de Azure donde se desplegarán los recursos"
  type        = string
  default     = "eastus"
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.azure_location))
    error_message = "La ubicación debe contener solo letras minúsculas, números y guiones."
  }
}

variable "azure_resource_group_name" {
  description = "Define el nombre base del grupo de recursos de Azure"
  type        = string
  default     = "fastdeployrg"
}

variable "azure_ad_display_name" {
  description = "Define el nombre base del grupo de Azure Active Directory para administradores de AKS"
  type        = string
  default     = "fastdeployadmins"
}

variable "azure_container_registry_name" {
  description = "Define el nombre base del Azure Container Registry (ACR)"
  type        = string
  default     = "fastdeployacr"
}

variable "azure_kubernetes_cluster_name" {
  description = "Define el nombre base del cluster de Azure Kubernetes Service (AKS)"
  type        = string
  default     = "fastdeployaks"
}

variable "azure_kubernetes_cluster_node_count" {
  description = "Define el número inicial de nodos en el pool por defecto del cluster AKS"
  type        = number
  default     = 1
  validation {
    condition     = var.azure_kubernetes_cluster_node_count >= 1 && var.azure_kubernetes_cluster_node_count <= 100
    error_message = "El número de nodos debe estar entre 1 y 100."
  }
}

variable "azure_kubernetes_cluster_vm_size" {
  description = "Define el tamaño de las máquinas virtuales para los nodos del cluster AKS"
  type        = string
  default     = "standard_a2_v2"
}

variable "azure_dns_prefix_aks" {
  description = "Define el prefijo DNS para el cluster de Azure Kubernetes Service"
  type        = string
  default     = "fastdeployaksdns"
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.azure_dns_prefix_aks))
    error_message = "El prefijo DNS debe contener solo letras minúsculas, números y guiones."
  }

}
