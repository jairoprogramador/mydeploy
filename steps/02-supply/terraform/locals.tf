locals {
  common_tags = merge({
    "project_name" : var.app_project_name,
    "project_team": var.app_team_name,
    "environment" : var.azure_environment,
  }, var.azure_resource_tags)

  suffixes = {
    resource_group = "${var.azure_environment}${random_id.resource_group_suffix.hex}"
    container_registry = "${var.azure_environment}${random_id.container_registry_suffix.hex}"
    kubernetes_cluster = "${var.azure_environment}${random_id.kubernetes_cluster_suffix.hex}"
    dns_prefix = "${var.azure_environment}${random_id.dns_prefix_suffix.hex}"
    active_directory_display_name = "${var.azure_environment}${random_id.active_directory_suffix.hex}"
  }
}
