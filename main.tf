terraform {
  required_providers {
    // docker provider configuration. => terraform registry
    docker = {
        source  = "kreuzwerker/docker"
        version = "3.0.2"
    }
  }
}
provider "docker" {
  
}

resource "docker_image" "front-end" {
   name = "front-end:latest"
#    keep_locally = false
}

resource "docker_container" "front-end" {
    image = docker_image.front-end.image_id
    name  = "front-end"
   
    ports {
        internal = 3000
        external = 8080
    }
}