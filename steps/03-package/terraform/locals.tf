locals {
  container = {
    image_uri_revision = "${data.azurerm_container_registry.current.login_server}/${var.app_project_name}:${var.app_project_revision}"
    image_uri_latest = "${data.azurerm_container_registry.current.login_server}/${var.app_project_name}:latest"
    image_uri_local = "${var.app_project_name}:${var.app_project_revision}"
  }
}