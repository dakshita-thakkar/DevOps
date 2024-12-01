# Specify the provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# Create a Docker image for Nginx
resource "docker_image" "nginx_image" {
  name         = "nginx:latest"
  keep_locally = false
}

# Create a Docker container using the Nginx image
resource "docker_container" "nginx_container" {
  name  = "nginx_container"
  image = docker_image.nginx_image.name
  ports {
    internal = 80
    external = 8080
  }
}

# Output the container name and ID
output "container_info" {
  value = {
    container_name = docker_container.nginx_container.name
    container_id   = docker_container.nginx_container.id
  }
}
