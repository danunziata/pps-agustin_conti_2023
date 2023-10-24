# k0s - k0sctl


## INSTALL K0sCTL

[k0sctl-linux-x64](https://github.com/k0sproject/k0sctl/releases/download/v0.16.0/k0sctl-linux-x64)

### Descarga de binario k0sctl
```bash
wget https://github.com/k0sproject/k0sctl/releases/download/v0.16.0/k0sctl-linux-x64
sudo install -o root -g root -m 0755 k0sctl-linux-x64 /usr/local/bin/kubectl

or 

sudo mv k0sctl-linux-x64 /usr/local/bin/k0sctl
sudo chown root:root /usr/local/bin/k0sctl
sudo chmod 755 /usr/local/bin/k0sctl
```

### crear 

### crear cluster 
```bash
k0sctl apply --config k0sctl.yaml
```
### borrar lo implementado:
```bash
 k0sctl reset
```
### Instale el binario kubectl con curl en Linux
Se instala en el anfitrion desde donde se va a aprovisionar el cluster que corresponde en este caso a vm virtualbox creadas con vagrant

### Descargue la última versión con el comando:
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client
```

### kubeconfig

Una vez creado los clusters con k0sctl e instalado kubectl, procedemos a crear el archivo kubeconfig para poder usar kubernetes con los clusters, primero vamos a generar este archivo con el siguiente comando.

```bash
k0sctl kubeconfig --config k0sctl.yaml > kubeconfig.config
```

Una ves generado el archivo, procedemos a realizar una prueba para obtener información de los clustres de la siguiente forma.

```bash
kubectl get node --kubeconfig kubeconfig.config
```
Ahora, para no tener que informar siempre el archivo kubeconfig.config, procedemos a guardarlo en una variable KUBECONFIG

```bash
export KUBECONFIG=/home/dani/Documents/pps-agustin_conti_2023/kubernetes/k0s/kubeconfig.config
```bash

Con esto solo ejecutamos lo siguiente:

```bash
kubectl get node
```

### las llaves ssh comando que se utilizó para crearlas

ssh-keygen -t rsa -b 4096 -C "danidev"

se le asigno el nombre k0s_key para tener el par de claves publico privada


## Opcional IDE para administrar clusters kubernetes

Usar la version Lens Desktop Personal

https://store.k8slens.dev/products/lens-desktop-personal

## Install Lens Desktop from the APT repository

1. Get the Lens Desktop public security key and add it to your keyring:
   ```
   curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null
   ```
2. Add the Lens Desktop repo to your `/etc/apt/sources.list.d` directory.
   Ubuntu newer than 18.04Ubuntu 18.04
   Specify the `stable` channel:

   ```
   echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list > /dev/null
   ```
3. Install or update Lens Desktop:
   ```
   sudo apt update
   sudo apt install lens
   ```
4. Run Lens Desktop:
   ```
   lens-desktop
   ```

## referencias
http://codigoelectronica.com/blog/instalar-k0sctl-en-ubuntu
https://kubernetes.io/es/docs/tasks/tools/included/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
https://kubernetes.io/es/docs/tasks/tools/included/install-kubectl-linux/
https://docs.k8slens.dev/getting-started/install-lens/
