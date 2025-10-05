resource "null_resource" "build_maven_package" {
  count = 1

  provisioner "local-exec" {
    command = "mvn clean package -DskipTests=true"
    working_dir = var.app_project_source_path
  }

  triggers = {
    dom_file_hash = filemd5("${var.app_project_source_path}/.fastdeploy/dom.yaml")
    pom_file_hash = filemd5("${var.app_project_source_path}/pom.xml")
    source_code_hash = sha256(join("", [
      for file in fileset("${var.app_project_source_path}/src", "**/*.java") :
      filesha256("${var.app_project_source_path}/src/${file}")
    ]))
  }
}

resource "null_resource" "build_docker_image" {
  depends_on = [null_resource.build_maven_package]
  
  provisioner "local-exec" {
    command = <<-EOT
      docker build \
        -t ${local.container.image_uri_versioned} \
        -t ${local.container.image_uri_latest} \
        -t ${local.container.image_uri_local} \
        -f ${var.docker_dockerfile_path} ${var.app_project_source_path}
    EOT
  }

  triggers = {
    dockerfile_hash = filemd5("${var.docker_dockerfile_path}")
    jar_file_hash = null_resource.build_maven_package[0].id
    image_tag = var.app_project_version
  }

}

resource "null_resource" "scan_trivy_security" {
  depends_on = [null_resource.build_docker_image]

  provisioner "local-exec" {
    command = <<-EOT
      docker run --rm \
      -v /var/run/docker.sock:/var/run/docker.sock \
      aquasec/trivy \
      image --exit-code 1 --severity HIGH,CRITICAL ${local.container.image_uri_local}
    EOT
  }

  triggers = {
    image_id = null_resource.build_docker_image.id
    image_tag = var.app_project_version
  }
}

resource "null_resource" "push_acr_image" {
  depends_on = [null_resource.scan_trivy_security]
  
  provisioner "local-exec" {
    command = "docker push ${local.container.image_uri_versioned}"
  }

  provisioner "local-exec" {
    command = "docker push ${local.container.image_uri_latest}"
  }

  triggers = {
    scan_result = null_resource.scan_trivy_security.id
    image_tag = var.app_project_version
  }

}

