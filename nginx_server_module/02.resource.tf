###### Resource ######

resource "google_compute_instance" "nginx-server" {
  name = var.instance_name
  machine_type = var.instance_type

  tags = var.target-tags

  boot_disk {
    initialize_params {
      image = var.instance_SO
    }
  }
    network_interface {
    network = var.instance_network
    access_config {
      // Ephemeral public IP (IP pública efímera)
    }
  }

  metadata_startup_script = replace(<<-EOF
    #!/bin/bash
    # Esperar a que la red y el servicio de paquetes estén listos (esto se hace por un tema del sistema de GCP que es asi)
    until ping -c1 8.8.8.8 &>/dev/null; do
      sleep 2
    done
    sudo apt-get update
    sudo apt-get install -y nginx
  EOF
  ,"\r","") # Hay que encapsular el script con replace(script,"\r","") para que lo tome bien en la instancia de GCP sin retornos de carro para que no genere error y se ejecute.

  metadata = {
    ssh-keys = "matmaxlab:${file("nginx-server.key.pub")}"
    # Para crear las llaves ssh ejecutar: ssh-keygen -t rsa -b 2048 -f "nombre.key"
  }
}