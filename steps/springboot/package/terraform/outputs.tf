output "image_name" {
  description = "Nombre completo de la imagen creada"
  value       = "${data.azurerm_container_registry.acr.login_server}/${var.project_name}:${var.project_version}"
}