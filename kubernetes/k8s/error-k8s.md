# Error k8s (SOLUCIONADO -> Checkear)

## Pasos para simular el error

1. Inicializar archivo de Vagrant

   Detalles a tener en cuenta:
   - Observar que la variable de `VB_MEMORY` es igual a `2048` , sino habrá problemas con la ejecución de cualquier configuración de Kubernetes debido a que el requerimiento minimo de memoria son 2GB.
   - Observar también que la nomenclatura e las máquinas virtuales ha sido modificada a `BASE_NAME = "k8s"`
   - Observar que **se ha borrado** la linea de la configuración de la red privada que decia `name: "vboxnet2"` ya que podía producir conflictos.
   - Recordar que **debes cambiar** las variables `PUB_KEY_PATH` y `PRIV_KEY_PATH` con los valores correspondientes a la ruta hacia tus claves pública y privada respectivamente.
   - Recordar que **debes cambiar** la variable `BASE_PUB_IP` a la correspondiente a tu red LAN del laboratorio u hogar.
   - Recordar que **debes cambiar** la variable `BRIDGED_IFACE` por la interfaz correspondiente a la que está conectada a tu red LAN del laboratorio u hogar.

   Ahora sí, podemos levantar las máquinas virtuales estando en el directorio correspondiente al archivo `Vagrantfile`:

   ```sh
   vagrant up

   # Para la eliminación de las máquianas creadas usar:
   # vagrant destroy
   ```

2. Entender el directory layout de `ansible/`:

   Existen "buenas prácticas" a la hora de acomodar los archivos que utilizamos para aprovisionar con Ansible. Podés encontrar más información acá: [Ansible Best Practicas - Directory Layout](https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html#DirectoryLayout)

   Luego de seguir a éste se acomodaron los directorios y archivos de la siguiente manera:

   ```sh
   > tree
   .
   ├── cluster_reset.yml
   ├── cluster_setup.yml
   ├── group_vars
   │   └── all.yml
   ├── host_vars
   ├── inventory.yml
   ├── old_files
   │   ├── ansible-get-join-command.yaml
   │   ├── ansible-hosts.txt
   │   ├── ansible-init-cluster.yml
   │   ├── ansible-install-kubernetes-dependencies.yml
   │   ├── ansible-join-workers.yml
   │   └── ansible-vars.yml
   ├── reset.yml
   ├── roles
   │   ├── get_join_command
   │   │   ├── defaults
   │   │   └── tasks
   │   │       └── main.yml
   │   ├── init_cluster
   │   │   ├── defaults
   │   │   └── tasks
   │   │       └── main.yml
   │   ├── install_kubernetes_dependencies
   │   │   ├── defaults
   │   │   └── tasks
   │   │       └── main.yml
   │   ├── join_workers
   │   │   ├── defaults
   │   │   └── tasks
   │   │       └── main.yml
   │   └── reset
   │       ├── defaults
   │       └── tasks
   │           └── main.yml
   └── site.yml
   ```

   Cada uno de estos directorios y archivos juega un papel importante en la organización de las configuraciones y tareas de Ansible. Los elementos principales de la estructura de directorios son:

   - `cluster_reset.yml` y `cluster_setup.yml`: Son los puntos de entrada para los playbooks de Ansible. Estos archivos especifican las tareas que se deben realizar en el entorno objetivo.

   - `group_vars/all.yml`: Acá se definen variables específicas de grupo que se aplicarán a todos los hosts en el inventario.

   - `host_vars/`: Este directorio se utilizaría para almacenar variables específicas de host si es necesario.

   - `inventory.yml`: Este archivo es donde se define nuestro inventario, es decir, la lista de hosts en los que Ansible ejecutará las tareas. Puedes definir grupos de hosts y asignar variables en este archivo.

   - `old_files/`: Este directorio contiene archivos antiguos o archivos de configuración anteriores que ya no se utilizan en el proyecto, es decir, los originales previos a la reestructuración.

   - `reset.yml`: Un playbook para restablecer la configuración de tu sistema o clúster.

   - `roles/`: Este directorio contiene los roles de Ansible, que son módulos reutilizables que definen tareas específicas. Cada rol tiene subdirectorios para las tareas y las variables por defecto asociadas a ese rol.

      - `get_join_command/`, `init_cluster/`, `install_kubernetes_dependencies/`, `join_workers/`, y `reset/` son los nombres de los roles que estás utilizando en tu proyecto.

      - Dentro de cada rol, hay subdirectorios `defaults` y `tasks` que contienen variables por defecto y tareas específicas para ese rol.

   - `site.yml`: Es un archivo de nivel superior que suele utilizarse para orquestar la ejecución de varios playbooks y roles en un orden específico.

   Notarás que como extra tenemos el playbook y role para hacer un reset de las configuraciones, entonces **no será necesario eliminar todas las máquinas virtuales para volver a comenzar en caso de error**.

3. Comprender lo que hace cada role en `roles`:

   - `install_kubernetes_dependencies`:
     - Instala paquetes necesarios para configurar Kubernetes y Docker, como `apt-transport-https`, `docker-ce`, `kubelet`, etc.
     - Configura claves de firma y repositorios para Docker y Kubernetes.
     - Asegura que Docker esté habilitado y en funcionamiento.
     - Deshabilita el archivo de swap y elimina las configuraciones de swap.
     - Reinicia el sistema para aplicar los cambios.

   - `init_cluster`:
     - Configura Docker para usar el controlador de cgroups systemd.
     - Inicializa el clúster de Kubernetes con un comando `kubeadm init`, especificando una máscara de subred para la red de pod.
     - Crea un directorio `.kube` en el directorio de inicio del usuario.
     - Configura el archivo de configuración de Kubernetes en el directorio de inicio del usuario.
     - Reinicia el servicio kubelet para aplicar las configuraciones.
     - Descarga y aplica las configuraciones de red Calico y el panel de control de Kubernetes Dashboard.

   - `get_join_command`:
     - Extrae el comando para unirse al clúster Kubernetes con el comando `kubeadm token create --print-join-command`.
     - Guarda el comando de unión en un archivo local (`join_command.out`).

   - `join_workers`:
     - Configura Docker para usar el controlador de cgroups systemd.
     - Lee el comando de unión del archivo local.
     - Ejecuta el comando de unión para agregar nodos trabajadores al clúster.

   - `reset`:
     - Elimina los paquetes de Kubernetes y Docker instalados previamente.
     - Elimina las claves de firma y los repositorios relacionados con Docker y Kubernetes.
     - Elimina cualquier configuración de intercambio y habilita el intercambio si estaba deshabilitado previamente.
     - Elimina la configuración del controlador de cgroups Docker.
     - Reinicia el sistema para aplicar los cambios.

4. Modificar la variable `ansible_private_key: tu_ruta/tu_clave_privada` del archivo `group_vars/all.yml`.

5. Comprobamos conectividad con todos los nodos:

   ```sh
   # En el directorio /ansible
   ansible -i inventory.yml -m ping all
   ```

   Obtendríamos el siguiente output:

   ```json
   k8s-3 | SUCCESS => {
      "ansible_facts": {
         "discovered_interpreter_python": "/usr/bin/python3"
      },
      "changed": false,
      "ping": "pong"
   }
   k8s-2 | SUCCESS => {
      "ansible_facts": {
         "discovered_interpreter_python": "/usr/bin/python3"
      },
      "changed": false,
      "ping": "pong"
   }
   k8s-1 | SUCCESS => {
      "ansible_facts": {
         "discovered_interpreter_python": "/usr/bin/python3"
      },
      "changed": false,
      "ping": "pong"
   }
   ```

6. Ejecutar el aprovisionamiento con Ansible:

   ```sh
   # En el directorio /ansible
   ansible-playbook -vvv site.yml -i inventory.yml 

   # En caso de querer resetear la configuración:
   
   # 1) Ejecutamos el role
   #ansible-playbook reset.yml -i inventory.yml
   
   # 2) Eliminamos el archivo creado con los commands
   # rm  rm join_command.out 

   # En caso de querer ejecutar sólo un role específico
   # ansible-playbook -vvv site.yml -i inventory.yml --tags tag_del_rol_a_ejecutar

   ```

## Errores que encontré

### Primer inconveniente - Error en la IP por defecto

Notaremos que todas las tareas asignadas a cada play (o role) funcionan correctamente hasta el play siguiente:

```sh
TASK [join_workers : join agents to cluster] 
```
En donde **no avanza la ejecución**.

Donde lo importante es ver que a la hora de ejecutarse el play de `get_join_command` tenemos el siguiente output:

```sh
TASK [join_workers : show join command] *****************************************************************
task path: /home/aagustin/Documents/personal/github-projects/pps-agustin_conti_2023/kubernetes/k8s/ansible/roles/join_workers/tasks/main.yml:20
ok: [k8s-2] => {
    "join_command_local.msg": "kubeadm join 10.0.2.15:6443 --token 0yensz.ndsalf3tvvs4st2a --discovery-token-ca-cert-hash sha256:d862eafa5bf271c8351024aa586d3fdec4da70effe16f6896002c4ece49d7958"
}
ok: [k8s-3] => {
    "join_command_local.msg": "kubeadm join 10.0.2.15:6443 --token 0yensz.ndsalf3tvvs4st2a --discovery-token-ca-cert-hash sha256:d862eafa5bf271c8351024aa586d3fdec4da70effe16f6896002c4ece49d7958"
```

Por otro lado si hacemo ssh en máquina master `k8s-1` y vemos el archivo de configuración creado nos encontramos con:

```sh
ssh -i ~/.ssh/vagrant_key vagrant@192.168.55.51
vagrant@k8s-1:~$ cat /home/vagrant/.kube/config 
```

```yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZ...
    server: https://10.0.2.15:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDR...
    client-key-data: LS0tLS1CRUdJTiBSU0E ...

```


#### Suposiciones

En un principio, entendí que se estaba asignando una interfaz que no era por defecto, tal cual como advertimos al configurar k0s. Entonces el problema numero de IP que se le asignaba al archivo de configuración para acceder a la API del nodo maestro.

Esta configuración se encontraría entonces al inicializar las configuraciones del nodo maestro `kube_master` al inicializar el cluster. Por esto lo relacioné directamente con la task de `TASK [init_cluster : Initialize Kubernetes cluster]`.

Por otro lado supuse que podía ser una mala configuración de la IP de los host a la hora de ejecutar el role de instalación de dependencias, la cual estaba comentada:

```yaml
#- name: Configure node IP
#  lineinfile:
#    path: /etc/default/kubelet
#    line: "KUBELET_EXTRA_ARGS=--node-ip={{ ansible_host }}"
```

Pero lo descarté porque habría una configuración del comando `kubectl init` que me permitiría setear la IP y puertos donde está la API.

#### Cambios realizados

Modifiqué el valor original de la task de:

```yaml
 name: Initialize Kubernetes cluster
  command: "kubeadm init --pod-network-cidr {{ pod_cidr }}"
  args:
    creates: /etc/kubernetes/admin.conf  # Skip this task if the file already exists
  register: kube_init
```

A esto:

```yaml
 name: Initialize Kubernetes cluster
  command: "kubeadm init --pod-network-cidr {{ pod_cidr }} --control-plane-endpoint {{ ansible_host }}:6443 --apiserver-advertise-address {{ ansible_host }} --apiserver-cert-extra-sans {{ ansible_host }}"
  args:
    creates: /etc/kubernetes/admin.conf  # Skip this task if the file already exists
  register: kube_init
```

Donde la variable `ansible_host` la toma del entorno y es la IP correspondiente al nodo que se está ejecutando en el momento, es decir, el que está asignado a ese role que en este caso es el `kube_master`.

#### Resultados de los cambios realzados

Con lo anterior realizado y luego de ejecutar el role de `reset` vemos que los comandos de join tienen la IP correcta, Ahora la task `TASK [join_workers : join agents to cluster]` se realiza correctamente y la salida del `show join commands` es:

```sh
TASK [get_join_command : show join command] *************************************************************
task path: /home/aagustin/Documents/personal/github-projects/pps-agustin_conti_2023/kubernetes/k8s/ansible/roles/get_join_command/tasks/main.yml:8
ok: [k8s-1] => {
    "join_command": {
        "changed": true,
        "cmd": [
            "kubeadm",
            "token",
            "create",
            "--print-join-command"
        ],
        "delta": "0:00:00.198791",
        "end": "2023-10-25 19:14:59.474163",
        "failed": false,
        "msg": "",
        "rc": 0,
        "start": "2023-10-25 19:14:59.275372",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "kubeadm join 192.168.55.51:6443 --token 8xv76a.dsz5aqm7rlg4oiee --discovery-token-ca-cert-hash sha256:ccadd0724fb1f530607025a428b52703a8314c33e3c6e0589a7d62bce5f8177a ",
        "stdout_lines": [
            "kubeadm join 192.168.55.51:6443 --token 8xv76a.dsz5aqm7rlg4oiee --discovery-token-ca-cert-hash sha256:ccadd0724fb1f530607025a428b52703a8314c33e3c6e0589a7d62bce5f8177a "
        ]
    }
}
```

Para verificar que tenemos el cluster, podemos ingresar via ssh al host master y ejecutar los comandos:

```sh
ssh -i ~/.ssh/vagrant_key vagrant@192.168.55.51
```

```sh
vagrant@k8s-1:~$ kubectl cluster-info
Kubernetes control plane is running at https://192.168.55.51:6443
CoreDNS is running at https://192.168.55.51:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

```

```sh
vagrant@k8s-1:~$ kubectl get nodes -o wide
NAME    STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
k8s-1   Ready    control-plane,master   8m24s   v1.23.6   10.0.2.15     <none>        Ubuntu 22.04.3 LTS   5.15.0-83-generic   docker://24.0.6
k8s-2   Ready    <none>                 4m45s   v1.23.6   10.0.2.15     <none>        Ubuntu 22.04.3 LTS   5.15.0-83-generic   docker://24.0.6
k8s-3   Ready    <none>                 4m45s   v1.23.6   10.0.2.15     <none>        Ubuntu 22.04.3 LTS   5.15.0-83-generic   docker://24.0.6

```

### Tener en cuenta: dudas

Vemos que cuando listamos los nodos tenemos configuradas mal las IPs internas, figuran las `10.0.2.15` que son las correspondientes a la interfaz por defecto `eth0`, la que requerimos que sea es la de la `eth2`, es decir las de la red privada `192.168.55.0/24`.

## Páginas que estuve consultando

- https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/
- https://github.com/virtualelephant/vsphere-kubernetes/blob/master/initialize-kubernetes.yml

- https://github.com/AudelDiaz/kubeadm-cluster/blob/main/ansible/roles/kubeadm-deploy-master/tasks/main.yml