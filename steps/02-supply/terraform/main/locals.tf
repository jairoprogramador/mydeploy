locals {
  tags = merge({
    "project_name" : var.app_project_name,
    "project_team": var.app_team_name,
    "environment" : var.app_environment,
  }, var.azure_resource_tags)

  prefix = {
    app_dns_prefix_aks = "${var.azure_dns_prefix_aks}${var.app_environment}${random_id.dns_prefix.hex}"
  }

  names = {
    app_rm_resource_group     = "${var.azure_resource_group_name}${var.app_environment}${random_id.resource_group.hex}"
    app_rm_kubernetes_cluster = "${var.azure_kubernetes_cluster_name}${var.app_environment}${random_id.kubernetes_cluster.hex}"
    app_ad_group              = "${var.azure_ad_group_name}${var.app_environment}${random_id.active_directory.hex}"
  }
}
