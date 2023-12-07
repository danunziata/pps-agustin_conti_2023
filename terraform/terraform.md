# Desplegar infra con terraform en proxmox




## Plantilla cloud init image linux

[create template script](create_template.sh)



##  Terraform

### Referencias
- https://developer.hashicorp.com/terraform

- https://austinsnerdythings.com/2021/09/01/how-to-deploy-vms-in-proxmox-with-terraform/

- https://devpress.csdn.net/linux/62e9fef120df032da732ab60.html

## 1 – Install

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform
```


## 2 – Authentication Method - API keys
Crear token en proxmox

API keys – this involves setting up a new user, giving that new user the required permissions, and then setting up API keys so that user doesn’t have to type in a password to perform actions


token_id: terraformuser@pam!terraformuser_token
secret: ebc81d5f-1e2d-4006-838f-b45fa770e7d6


## 3 – Terraform basic information and provider installation

 en proxmox fijarse que esten los permisos sobre local-lvm para el usuario o grupo 


## 4 - Terraform files

[main.tf](main.tf)

[vars.tf](vars.tf)

## 5 – Terraform commands

**terraform init:** Este comando se utiliza para inicializar un directorio de trabajo de Terraform. Descarga y configura los proveedores de infraestructura necesarios, así como cualquier módulo de Terraform que esté siendo utilizado. Es el primer comando que se debe ejecutar al trabajar con un nuevo proyecto de Terraform.

´´´bash
terraform init
´´

**terraform plan:** Con este comando, Terraform crea un plan de ejecución detallado de los cambios que se aplicarán a la infraestructura. Examina los archivos de configuración de Terraform y determina qué recursos se crearán, modificarán o eliminarán. El plan también muestra los valores de los atributos de los recursos y cualquier cambio propuesto.

´´´bash
terraform plan
´´


**terraform apply:** Este comando aplica los cambios definidos en el archivo de configuración de Terraform y realiza las acciones necesarias para lograr el estado deseado de la infraestructura. Terraform leerá el plan generado por el comando terraform plan y solicitará confirmación antes de aplicar los cambios. Una vez confirmado, Terraform creará, modificará o eliminará los recursos según lo especificado.

´´´bash
terraform apply
´´

**terraform destroy:** Con este comando, Terraform destruye todos los recursos administrados por el archivo de configuración y los elimina de la infraestructura. Terraform consulta el estado actual y realiza la eliminación de manera ordenada, destruyendo los recursos en el orden inverso al que se crearon.

´´´bash
terraform destroy
´´

