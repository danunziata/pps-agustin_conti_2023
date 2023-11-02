# Automatización de la implementación de Kubernetes (k8s) en máquinas Vagrant utilizando Ansible

## Pasos para el aprovisionamiento

1. Cargar nuestra propia configuración de Vagrant en config_vms.yaml

   Detalles a tener en cuenta:
   - Dependiendo de la cantidad de máquinas virtuales que requieras para tu laboratorio **deberás cambiar** la variable `vms` al número correspondiente.
   - Observar que la variable de `vb_memory` es igual a `2048` , sino habrá problemas con la ejecución de cualquier configuración de Kubernetes debido a que el requerimiento **minimo de memoria son 2GB.**
   - Recordar que **debes cambiar** las variables `pub_key_path` y `priv_key_path` con los valores correspondientes a la ruta hacia tus claves pública y privada respectivamente.
   - Recordar que **debes cambiar** la variable `base_pub_ip` a la correspondiente a tu red LAN del laboratorio u hogar.
   - Recordar que **debes cambiar** la variable `bridged_iface` por la interfaz correspondiente a la que está conectada a tu red LAN del laboratorio u hogar.

   Deberás colocar en la variable `env` la correspondiente a tu configuración, quedando como sigue:

   ```yaml
   ---
   vagrant_config:
   env: 'tu_usuario'
   users:
      tu_usuario:
         base_name: "k8s"
         base_image: "bento/ubuntu-22.04"
         base_image_version: "202309.08.0"
         #### -> Resto de tus configuraciones
   ```

   Ahora sí, podemos levantar las máquinas virtuales estando en el directorio correspondiente al archivo `Vagrantfile`:

   ```sh
   vagrant up
   ```

   Para la eliminación de las máquianas creadas usar:

   ```sh
   vagrant destroy
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

5. Checkear que se hayan levantado correctamente las máquinas virtuales:

   ```sh
   > vagrant status
   Current machine states:

   k8s-1                     running (virtualbox)
   k8s-2                     running (virtualbox)
   k8s-3                     running (virtualbox)

   This environment represents multiple VMs. The VMs are all listed
   above with their current state. For more information about a specific
   VM, run `vagrant status NAME`.
   ```

6. **¡Atención!** Según tus requerimientos en cuanto a cantidad de máquinas virtuales (cual número definiste en la variable `vms` del archivo de configuración `config_vms.yaml`) deberás modificar el inventario:

   ```yaml
   ---

   all:
   children:
      kube_server:
         hosts:
         k8s-1:
            ansible_host: "{{ foo.base_host_ip }}.{{ foo.start_host_ip + 1 }}"
      kube_agents:
         hosts:
         k8s-2:
            ansible_host: "{{ foo.base_host_ip }}.{{ foo.start_host_ip + 2 }}"
         k8s-3:
            ansible_host: "{{ foo.base_host_ip }}.{{ foo.start_host_ip + 3 }}"
   ```

   En nuestro caso, tenemos 3 máquinas virtuales, en el caso de haber más o menos nos aseguraremos de agregarla o eliminarla según corresponda.

7. Comprobamos conectividad con todos los nodos:

   ```sh
   # En el directorio /ansible
   ansible -i inventory.yml -m ping all
   ```

   Obtendríamos el siguiente output:

   ```json
   k8s-1 | SUCCESS => {
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
   k8s-3 | SUCCESS => {
      "ansible_facts": {
         "discovered_interpreter_python": "/usr/bin/python3"
      },
      "changed": false,
      "ping": "pong"
   }
   ```

8. Ejecutar el aprovisionamiento con Ansible:

   ```sh
   # En el directorio /ansible
   ansible-playbook -vvv site.yml -i inventory.yml
   ```

   En caso de querer resetear la configuración:

   ```sh
   # 1) Ejecutamos el role
   ansible-playbook reset.yml -i inventory.yml
   
   # 2) Eliminamos el archivo creado con los commands
   rm  rm join_command.out 
   ```

   En caso de querer ejecutar sólo un role específico

   ```sh  
   ansible-playbook -vvv site.yml -i inventory.yml --tags tag_del_rol_a_ejecutar
   ```

9. Checkear que todo se haya ejecutado correctamente:

   Primero, veremos que el output luego de ejecutar el playbook de Ansible es el siguiente:

   ```sh
   PLAY RECAP **********************************************************************************************
   k8s-1                      : ok=31   changed=21   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
   k8s-2                      : ok=21   changed=12   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
   k8s-3                      : ok=21   changed=16   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
   ```

   Segundo, ingresamos por SSH a la máquina que hayamos definido como control-plane o master y nos fijaremos los nodos:

   ```sh
   > ssh -i ~/.ssh/vagrant_key vagrant@192.168.55.51
   Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-83-generic x86_64)

   * Documentation:  https://help.ubuntu.com
   * Management:     https://landscape.canonical.com
   * Support:        https://ubuntu.com/advantage

   System information as of Thu Nov  2 05:33:07 PM UTC 2023

   System load:  1.34521484375      Users logged in:          0
   Usage of /:   15.6% of 30.34GB   IPv4 address for docker0: 172.17.0.1
   Memory usage: 12%                IPv4 address for eth0:    10.0.2.15
   Swap usage:   0%                 IPv4 address for eth1:    192.168.102.51
   Processes:    166                IPv4 address for eth2:    192.168.55.51


   This system is built by the Bento project by Chef Software
   More information can be found at https://github.com/chef/bento
   Last login: Thu Nov  2 17:34:59 2023 from 192.168.55.1
   
   vagrant@k8s-1:~$ kubectl get nodes
   NAME    STATUS   ROLES                  AGE   VERSION
   k8s-1   Ready    control-plane,master   2m    v1.23.6
   k8s-2   Ready    <none>                 96s   v1.23.6
   k8s-3   Ready    <none>                 96s   v1.23.6
   ```

**¡Listo!** Tenemos nuestro pequeño cluster de Kubernetes levantado en nuestro entorno de laboratorio.

## Referencias

- [Kubernetes Setup Using Ansible and Vagrant](https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/)
- [GitHub - AudelDiaz - kubeadm-cluster](https://github.com/AudelDiaz/kubeadm-cluster/blob/main/ansible/roles/kubeadm-deploy-master/tasks/main.yml)
- [Ansible Best Practicas - Directory Layout](https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html#DirectoryLayout)
