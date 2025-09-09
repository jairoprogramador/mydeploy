locals {
  common_tags = merge({
    "project" : var.project.name,
    "environment" : var.environment,
    "managed-by" : "fastdeploy",
    "layer" : "platform",
    "component" : "acr-cache"
  }, var.tags)

  suffixes = {
    rg = "${var.environment}${random_id.random_rg_name.hex}"
    cr = "${var.environment}${random_id.random_cr_name.hex}"
    kc = "${var.environment}${random_id.random_kc_name.hex}"
    dns = "${var.environment}${random_id.random_dns_api_aks.hex}"
    ad = "${var.environment}${random_id.random_ad_name.hex}"
  }
}

