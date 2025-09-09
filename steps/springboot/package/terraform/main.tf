resource "null_resource" "maven_build" {
  count = 1
  
  triggers = {
    pom_file_hash = filemd5("${var.project_source_path}/pom.xml")
    source_code_hash = sha256(join("", [
      for file in fileset("${var.project_source_path}/src", "**/*.java") :
      filesha256("${var.project_source_path}/src/${file}")
    ]))
  }

  provisioner "local-exec" {
    command = "mvn clean package -DskipTests=true"
    working_dir = var.project_source_path
  }
}

resource "null_resource" "docker_build_push" {
  depends_on = [null_resource.maven_build]
  
  triggers = {
    dockerfile_hash = filemd5("${var.dockerfile_path}")
    jar_file_hash = null_resource.maven_build[0].id
    image_tag = var.project_version
  }

  # Build de la imagen Docker
  provisioner "local-exec" {
    command = "docker build -t ${data.azurerm_container_registry.acr.login_server}/${var.project_name}:${var.project_version} -f ${var.dockerfile_path} ${var.project_source_path}"
  }

  # Push de la imagen al ACR
  provisioner "local-exec" {
    command = "docker push ${data.azurerm_container_registry.acr.login_server}/${var.project_name}:${var.project_version}"
  }

  # También crear tag latest si se especifica
  provisioner "local-exec" {
    command = "docker tag ${data.azurerm_container_registry.acr.login_server}/${var.project_name}:${var.project_version} ${data.azurerm_container_registry.acr.login_server}/${var.project_name}:latest && docker push ${data.azurerm_container_registry.acr.login_server}/${var.project_name}:latest"
  }
}
