# Dual NGINX Server IaaC (`dual_nginx_server_IaaC`)

Despliegue de servidores web con **NGINX** en **Google Cloud Platform (GCP)** utilizando **Terraform** y un módulo reutilizable (`nginx_server_module`).

## Estructura del repositorio

```text
├── main.tf
├── .gitignore
└── nginx_server_module/
    ├── 00.variables.tf
    ├── 01.provider.tf
    ├── 02.resource.tf
    ├── 03.firewall.tf
    └── 04.outputs.tf
```

## Qué crea el módulo (`nginx_server_module`)

* **Instancia de Compute Engine (`google_compute_instance`)**: crea la VM con el tipo de máquina, imagen de SO y red configurados, asigna una IP pública efímera, espera conectividad de red en el `startup_script` e instala `nginx` automáticamente.
* **Reglas de firewall (`google_compute_firewall`)**:
  * `permitir_http`: habilita el puerto TCP `80` (`0.0.0.0/0`) para los `network tags` definidos.
  * `permitir_ssh`: habilita el puerto TCP `22` restringido al rango de **IAP** (`35.235.240.0/20`) para los `network tags` definidos.
* **Clave SSH**: inyecta la clave pública (`nginx-server.key.pub`) en la metadata de la instancia para el usuario `matmaxlab`.
* **Output**: expone `server_public_ip` con la IP pública asignada a la instancia.

## Requisitos previos

1. Cuenta y proyecto en **GCP** con la API de Compute Engine habilitada.
2. **Terraform** y **Google Cloud CLI (`gcloud`)** instalados y autenticados localmente.
3. Par de claves SSH generado (por ejemplo, `nginx-server.key` y `nginx-server.key.pub`) con `ssh-keygen -t rsa -b 2048 -f "nginx-server.key"`.

## Uso

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/MatiasMaxRodriguez/dual_nginx_server_IaaC.git
   cd dual_nginx_server_IaaC
   ```

2. **Configurar los bloques de módulo en `main.tf`** para instanciar los servidores reutilizando `./nginx_server_module` y pasando las variables requeridas (`project`, `region`, `zone`, `instance_name`, `instance_type`, `instance_SO`, `instance_network`, `env`, `target-tags`).

3. **Inicializar y aplicar con Terraform:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. **Conectarse por SSH mediante IAP:**
   ```bash
   gcloud compute ssh matmaxlab@<nombre_de_servidor> --zone=<zona> --tunnel-through-iap
   ```

5. **Limpiar recursos:**
   ```bash
   terraform destroy
   ```
