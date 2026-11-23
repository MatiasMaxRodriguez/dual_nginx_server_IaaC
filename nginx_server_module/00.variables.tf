###### Variables ######

variable "project" {
  description = "Nombre del proyecto GCP"
  #default = "mmrlab-ngserver"
}

variable "region" {
  description = "Region de la instancia"
  #default = "us-central1"
}

variable "zone" {
  description = "Zona de la instancia"
  #default = "us-central1-a"
}

variable "instance_name" {
  description = "Nombre de la instancia"
  #default = "nginxserver"
}

variable "instance_type" {
  description = "Tipo de instancia"
  #default = "e2-micro"
}

variable "instance_SO" {
  description = "Sistema Operativo de la instancia"
  #default = "debian-12"
}

variable "instance_network" {
  description = "Nombre de red de la instancia"
  #default = "default"
}

variable "env" {
  description = "Nombre o sufijo del entorno (ej. dev, qa)"
}

variable "target-tags" {
  type = list(string)
  description = "Network tags a los que aplica la regla firewall"
}