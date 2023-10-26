# k0s - k0sctl

K0sctl es una herramienta de línea de comandos para arrancar y gestionar clusters k0s. k0sctl se conecta a los hosts proporcionados mediante SSH y recopila información sobre los mismos, con los que forma un cluster configurandolos, desplegando k0s y conectando los nodos k0s entre sí.

Se instala en el anfitrion desde donde se va a aprovisionar el cluster que corresponde en este caso a vm virtualbox creadas con vagrant.

## Crear máquinas virtuales

Antes debemos cambiar el valor de las siguientes variables:

- `USER_DIR_PATH`: Con la ruta de tu usuario de linux.
- `PUB_KEY_PATH`: Con la ruta a la clave SSH pública.
- `PRIV_KEY_PATH`: Con la ruta a la clave SSH privada.
- `BASE_PUB_IP`: Con la IP de tu red LAN.
- `BRIDGED_IFACE`: Con el nombre de la interfaz conectada a tu red LAN.

Luego si, podemos crearlas:

```sh
# En la ubicación de la Vagrantfile
vagrant up
```

Para eliminarlas:

```sh
# En la ubicación de la Vagrantfile
vagrant destroy
```

## Crear las claves SSH

```sh
ssh-keygen -t rsa -b 4096 -C "algun-identificador-personal"
```

Se le asigno el nombre `k0s_key` para tener el par de claves publico privada.

## K0sctl

### Descarga e instalación de K0sctl en la máquina HOST

[k0sctl-linux-x64](https://github.com/k0sproject/k0sctl/releases/download/v0.16.0/k0sctl-linux-x64)

- Descargamos el binario:

   ```sh
   wget https://github.com/k0sproject/k0sctl/releases/download/v0.16.0/k0sctl-linux-x64
   ```

- Instalamos el binario en `/usr/local/bin/k0sctl`:

   ```sh
   sudo install -o root -g root -m 0755 k0sctl-linux-x64 /usr/local/bin/k0sctl
   ```

- Otra opción para la instalación en `/usr/local/bin/k0sctl`:

   ```sh
   sudo mv k0sctl-linux-x64 /usr/local/bin/k0sctl
   sudo chown root:root /usr/local/bin/k0sctl
   sudo chmod 755 /usr/local/bin/k0sctl
   ```

- Verificamos la instalación observando la versión instalada:

   ```sh
   k0sctl version
   ```

### Crear el archivo de configuración por defecto en el directorio de trabajo

Creamos el archivo por defecto:

```sh
# En la carpeta del proyecto
k0sctl init > k0sctl.yaml
```

Lo modificamos para que quede de la siguiente manera:

```yaml
apiVersion: k0sctl.k0sproject.io/v1beta1
kind: Cluster
metadata:
  name: k0s-cluster
spec:
  hosts:
  - ssh:
      address: 192.168.55.51 
      user: root
      port: 22
      keyPath: /path/to/private/key/k0s_key
    role: controller
    privateInterface: eth2
  - ssh:
      address: 192.168.55.52
      user: root
      port: 22
      keyPath: /path/to/private/key/k0s_key
    role: worker
    privateInterface: eth2
  - ssh:
      address: 192.168.55.53 
      user: root
      port: 22
      keyPath: /path/to/private/key/k0s_key
    role: worker
    privateInterface: eth2
 
  k0s:
    version: 1.28.2+k0s.0
```

Donde los parámetros importantes son:

- `address`: Donde pondremos la dirección IP del host correspondiente a la red privada.
- `keyPath`: Donde indicaremos la ruta hacia nuetra clave privada SSH.
- `privateInterface`: Al ejecutarse la configuración se tomará por defecto la interfaz `eth0`, que en nuestro caso, al usar Vagrant, se corresponde a la IP de la NAT, por eso deberemos agregar este parámetro indicando la interfaz asociada a la red privada.
- `role`: Deberemos asignar el rol de `controller` o `worker` segun corresponda.
- Deberemos **añadir tantos workers o controllers como necesitemos** crear y segun corresponda respecto a la cantidad de VM's creadas.

### Crear cluster

En la carpeta donde creamos el archivo k0sctl.yaml

```sh
k0sctl apply --config k0sctl.yaml
```

### Borrar lo implementado

```sh
 k0sctl reset
```

## Kubectl

Kubectl es la herramienta de línea de comandos específica de Kubernetes que le permite comunicar y controlar los clústeres de Kubernetes. Es capaz de crear, gestionar y eliminar recursos de nuestra plataforma de Kubernetes.

Se instala en el anfitrion desde donde se va a aprovisionar el cluster que corresponde en este caso a vm virtualbox creadas con vagrant.

### Descarga e instalación de Kubectl en la máquina HOST

- Descargargamos el binario con curl:

   ```sh
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   ```

- Instalamos en `/usr/local/bin/kubectl`:

   ```sh
   sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
   ```

- Verificamos la instalación observando la versión instalada:

   ```sh
   kubectl version --client
   ```

## Kubeconfig

Una vez creado los clusters con k0sctl e instalado kubectl, procedemos a crear el archivo kubeconfig para poder usar kubernetes con los clusters, primero vamos a generar este archivo con el siguiente comando.

```sh
k0sctl kubeconfig --config k0sctl.yaml > kubeconfig.config
```

Una ves generado el archivo, procedemos a realizar una prueba para obtener información de los clustres de la siguiente forma.

```sh
kubectl get node --kubeconfig kubeconfig.config
```

Ahora, para no tener que informar siempre el archivo kubeconfig.config, procedemos a guardarlo en una variable KUBECONFIG

```sh
export KUBECONFIG=/home/dani/Documents/pps-agustin_conti_2023/kubernetes/k0s/kubeconfig.config
```

Con esto solo ejecutamos lo siguiente:

```sh
kubectl get node
```

## Opcional IDE para administrar clusters kubernetes

Usar la version Lens Desktop Personal

<https://store.k8slens.dev/products/lens-desktop-personal>

## Install Lens Desktop from the APT repository

1. Get the Lens Desktop public security key and add it to your keyring:

   ```sh
   curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null
   ```

2. Add the Lens Desktop repo to your `/etc/apt/sources.list.d` directory.
   Ubuntu newer than 18.04Ubuntu 18.04
   Specify the `stable` channel:

   ```sh
   echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list > /dev/null
   ```

3. Install or update Lens Desktop:

   ```sh
   sudo apt update
   sudo apt install lens
   ```

4. Run Lens Desktop:

   ```sh
   lens-desktop
   ```

## Problema

Continúo con el mismo problema a la hora de inicializar, me quedo en:

```sh
> k0sctl apply --config k0sctl.yaml

⠀⣿⣿⡇⠀⠀⢀⣴⣾⣿⠟⠁⢸⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀█████████ █████████ ███
⠀⣿⣿⡇⣠⣶⣿⡿⠋⠀⠀⠀⢸⣿⡇⠀⠀⠀⣠⠀⠀⢀⣠⡆⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀███          ███    ███
⠀⣿⣿⣿⣿⣟⠋⠀⠀⠀⠀⠀⢸⣿⡇⠀⢰⣾⣿⠀⠀⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀███          ███    ███
⠀⣿⣿⡏⠻⣿⣷⣤⡀⠀⠀⠀⠸⠛⠁⠀⠸⠋⠁⠀⠀⣿⣿⡇⠈⠉⠉⠉⠉⠉⠉⠉⠉⢹⣿⣿⠀███          ███    ███
⠀⣿⣿⡇⠀⠀⠙⢿⣿⣦⣀⠀⠀⠀⣠⣶⣶⣶⣶⣶⣶⣿⣿⡇⢰⣶⣶⣶⣶⣶⣶⣶⣶⣾⣿⣿⠀█████████    ███    ██████████
k0sctl v0.16.0 Copyright 2023, k0sctl authors.
Anonymized telemetry of usage will be sent to the authors.
By continuing to use k0sctl you agree to these terms:
https://k0sproject.io/licenses/eula
WARN An old cache directory still exists at /home/aagustin/.k0sctl/cache, k0sctl now uses /home/aagustin/.cache/k0sctl 
INFO ==> Running phase: Connect to hosts 
```

A tener en cuenta:

- Tengo conectividad:

   ```sh
   > ping 192.168.55.51 
   PING 192.168.55.51 (192.168.55.51) 56(84) bytes of data.
   64 bytes from 192.168.55.51: icmp_seq=1 ttl=64 time=0.550 ms
   64 bytes from 192.168.55.51: icmp_seq=2 ttl=64 time=0.654 ms
   64 bytes from 192.168.55.51: icmp_seq=3 ttl=64 time=0.684 ms
   ^C
   --- 192.168.55.51 ping statistics ---
   3 packets transmitted, 3 received, 0% packet loss, time 2052ms
   rtt min/avg/max/mdev = 0.550/0.629/0.684/0.057 ms   
   ```

- Tengo acceso ssh:

   ```sh
   > ssh -i ~/.ssh/k0s_key root@192.168.55.51
   Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-83-generic x86_64)

   * Documentation:  https://help.ubuntu.com
   * Management:     https://landscape.canonical.com
   * Support:        https://ubuntu.com/advantage

   System information as of Thu Oct 26 03:19:24 PM UTC 2023

   System load:  0.0859375          Users logged in:       0
   Usage of /:   12.6% of 30.34GB   IPv4 address for eth0: 10.0.2.15
   Memory usage: 24%                IPv4 address for eth1: 192.168.102.51
   Swap usage:   0%                 IPv4 address for eth2: 192.168.55.51
   Processes:    140


   This system is built by the Bento project by Chef Software
   More information can be found at https://github.com/chef/bento
   Last login: Thu Oct 26 14:20:38 2023 from 192.168.55.1
   root@k0s-1:~# 
   ```
- El puerto 22 está en escucha:

   ```sh
   root@k0s-1:~# ss -tulpn | grep LISTEN
   tcp   LISTEN 0      4096    127.0.0.53%lo:53        0.0.0.0:*    users:(("systemd-resolve",pid=638,fd=14)) 
   tcp   LISTEN 0      128           0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=710,fd=3))             
   tcp   LISTEN 0      128              [::]:22           [::]:*    users:(("sshd",pid=710,fd=4))             
   root@k0s-1:~# 
   ```

## Referencias

- <http://codigoelectronica.com/blog/instalar-k0sctl-en-ubuntu>
- <https://kubernetes.io/es/docs/tasks/tools/included/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux>
- <https://kubernetes.io/es/docs/tasks/tools/included/install-kubectl-linux/>
- <https://docs.k8slens.dev/getting-started/install-lens/>
