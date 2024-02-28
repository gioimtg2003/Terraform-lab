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

variable "containers" {
  type = number
  default = 10
}

resource "docker_image" "nginx" {
   name = "nginx:alpine-perl" // "nginx:alpine-perl"
   keep_locally = false
}

resource "docker_container" "nginx" {
    for_each = { for i in range(var.containers): i => i }
    image = docker_image.nginx.image_id
    name  = "container-nginx-${each.key}"
    ports{
        internal = 80 + each.key
        external = 8080 + each.key
    }
}

# terraform {
#   required_providers {
#     virtualbox = {
#       source = "shekeriev/virtualbox"
#       version = "0.0.4"
#     }
#   }
# }

# provider "virtualbox" {
#     delay      = 60
#     mintimeout = 5
# }

# resource "virtualbox_vm" "vm1" {
#     name = "xenial64"
#     image = "./xenial-server-cloudimg-amd64-vagrant.box"
#     cpus = 1
#     memory = "1024 mib"
#     // user_data = file("${path.module}/user_data")
#     //user name and password = vagrant
#     network_adapter {
#         type = "bridged"
#         host_interface = "Intel(R) Wi-Fi 6 AX200 160MHz"
#     }
    
# }
# output "IPAddress" {
#     value = element(virtualbox_vm.vm1.*.network_adapter.0.ipv4_address, 1)
# }