###### Outputs ######

output "server_public_ip" {
  description = "IP Publica de la instancia"
  value = google_compute_instance.nginx-server.network_interface[0].access_config[0].nat_ip
}