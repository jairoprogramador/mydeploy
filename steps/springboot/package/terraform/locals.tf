locals {
  common_tags = merge({
    "project" : var.project.name,
    "environment" : var.environment,
    "managed-by" : "fastdeploy",
    "layer" : "application",
    "component" : "package"
  }, var.tags)
}