output "azure_image_uri_versioned" {
  description = "Devuelve el URI de la imagen creada"
  value       = local.container.image_uri_revision
}