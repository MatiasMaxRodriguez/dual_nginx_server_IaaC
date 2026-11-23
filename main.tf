###### Modulos ######

module "nginx_server_dev" {
  source = "./nginx_server_module"

  project = "mmrlab-ngserver"
  region = "us-west1"
  zone = "us-west1-b"
  instance_name = "nginxserver-dev"
  instance_type = "e2-medium"
  instance_SO = "debian-12"
  instance_network = "default"
  env = "dev"
  target-tags = ["nginx-dev"]
}

module "nginx_server_qa" {
  source = "./nginx_server_module"

  project = "mmrlab-ngserver"
  region = "us-west1"
  zone = "us-west1-b"
  instance_name = "nginxserver-qa"
  instance_type = "e2-small"
  instance_SO = "debian-12"
  instance_network = "default"
  env = "qa"
  target-tags = ["nginx-qa"]
}

###### Outputs ######

output "nginx_dev_ip" {
  description = "IP Publica de la instancia dev"
  value = module.nginx_server_dev.server_public_ip # Se instancia la IP publica del archivo 04.outputs.tf del modulo nginx_server_module
}

output "nginx_qa_ip" {
  description = "IP Publica de la instancia qa"
  value = module.nginx_server_qa.server_public_ip # Se instancia la IP publica del archivo 04.outputs.tf del modulo nginx_server_module
}