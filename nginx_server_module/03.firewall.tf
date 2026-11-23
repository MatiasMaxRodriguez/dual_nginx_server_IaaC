###### Firewall ######

resource "google_compute_firewall" "permitir_http" {
  name = "permitir-http-${var.env}"
  network = var.instance_network

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = var.target-tags
}

resource "google_compute_firewall" "permitir_ssh" {
  name    = "permitir-ssh-${var.env}"
  network = var.instance_network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"] # Esta configuracion de IP es para realizar una conexion SSH por tunel IAP mas por seguridad y para no utilizar 0.0.0.0/0
  target_tags   = var.target-tags
  # Luego desde cliente local o terminal local ejecutar: gcloud compute ssh usuario@nombre_de_servidor --zone=zona --tunnel-through-iap
  # para comunicarse a traves de SSH con IAP y al tener guardadas las claves (key) esta las lee y realiza la comunicacion automaticamente.
}