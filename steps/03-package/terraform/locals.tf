locals {
  container = {
    image_uri_versioned = "${data.azurerm_container_registry.current.login_server}/${var.app_project_name}:${var.app_project_version}"
    image_uri_latest = "${data.azurerm_container_registry.current.login_server}/${var.app_project_name}:latest"
  }
}