# Test Cluster Lab

## Pasos para la conexión con el cluster

1. Adquisición de clave privada y guardado en `~/.ssh/cluster_key`.
2. Aprovisionamos 3 máquinas virtuales con Terraform con los siguientes recursos y configuraciones:

    |  VM-ID | USER | IP | Gateway | CPUs | RAM | DISK |
    | --- | --- | --- | --- | --- | --- | --- |
    |  701 | labredes | 192.168.100.171 | 192.168.100.1 | 8 | 8192 MB | 20 GB |
    |  702 | labredes | 192.168.100.172 | 192.168.100.1 | 8 | 8192 MB | 20 GB |
    |  703 | labredes | 192.168.100.173 | 192.168.100.1 | 8 | 8192 MB | 20 GB |

    a. Para levantar máquinas virtuales:

      ```sh
      terraform apply -y
      ```

    b. Para borrar las máquinas:

      ```sh
      terraform destroy -y
      ```

3. Comprobamos acceso SSH a los nodos (recordar estar conectado a la red correspondiente para tener acceso):

    ```sh
    # Repetir para .171, .172 y .173
    ssh -i ~/.ssh/cluster_key labredes@192.168.100.171
    ```

    Deberíamos obtener el siguiente output en las 3 máquinas:

    ```bash
    > ssh -i ~/.ssh/cluster_key labredes@192.168.100.171
    The authenticity of host '192.168.100.171 (192.168.100.171)' can't be established.
    ED25519 key fingerprint is SHA256:w/4Pnyu5Es3kLjO+QvECEY9GeAvSOkOdh08JNvwMjMI.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added '192.168.100.171' (ED25519) to the list of known hosts.
    Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-86-generic x86_64)

    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/advantage

      System information as of Mon Nov  6 13:10:31 UTC 2023

      System load:  0.0                Processes:             151
      Usage of /:   10.3% of 19.20GB   Users logged in:       0
      Memory usage: 4%                 IPv4 address for eth0: 192.168.100.171
      Swap usage:   0%

    Expanded Security Maintenance for Applications is not enabled.

    0 updates can be applied immediately.

    Enable ESM Apps to receive additional future security updates.
    See https://ubuntu.com/esm or run: sudo pro status


    *** System restart required ***

    The programs included with the Ubuntu system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.

    Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
    applicable law.

    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.

    labredes@k8spps1:~$ 
    ```

4. Configuramos las variables de Ansible (`k8s/ansible/group_vars/all.yml`)para poder tener acceso:

    ```yaml
    foo:
      base_host_ip: "192.168.100"
      start_host_ip: 170

    # SSH configuration
    ansible_ssh_user: labredes
    ansible_ssh_private_key_file: /home/aagustin/.ssh/cluster_key
    #ansible_ssh_pass:



    # specifying a CIDR for our cluster to use.
    # # can be basically any private range except for ranges already in use.
    # # apparently it isn't too hard to run out of IPs in a /24, so we're using a /22
    pod_cidr: "10.244.0.0/16"

    # this defines what the join command filename will be
    join_command_location: "join_command.out"

    # setting the home directory for retreiving, saving, and executing files
    home_dir: "/home/labredes/"

    remote_user: "labredes"
    ```

5. Comprobamos conectividad vía SSH:

    ```sh
    ansible -i ansible/inventory.yml -m ping all
    ```

    Deberíamos tener lo siguiente:

    ```json
    k8s-3 | SUCCESS => {
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
    k8s-2 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "ping": "pong"
    }
    ```

6. Nos aseguramos que en `ansible/roles/install_kubernetes_dependencies/tasks/main.yml` la versión de los paquetes sea la que sigue:

    ```yaml
    apt:
    name: "{{ packages }}"
    state: present
    update_cache: yes
    vars:
    packages:
        - kubelet=1.21.10-00
        - kubeadm=1.21.10-00
        - kubectl=1.21.10-00
    ```

7. Ejecutamos el aprovisionamiento de k8s:

    ```sh
    ansible-playbook -vvv ansible/site.yml -i ansible/inventory.yml
    ```

    Deberíamos obtener el siguiente output:

    ```sh
    PLAY RECAP **************************************************************************************************************************************************************************
    k8s-1                      : ok=31   changed=22   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
    k8s-2                      : ok=21   changed=13   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
    k8s-3                      : ok=21   changed=13   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
    ```

8. Accedemos por SSH a la máquina `master` y revisamos que estén los nodos levantados:
  
    Accedemos por SSH:

    ```sh
    ssh -i ~/.ssh/cluster_key labredes@192.168.100.171
    ```

    Revisamos los nodos:

    ```sh
    kubectl get nodes -o wide
    ```

    Deberíamos obtener lo siguiente:

    ```sh
    NAME      STATUS   ROLES                  AGE    VERSION   INTERNAL-IP       EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
    k8spps1   Ready    control-plane,master   2m4s   v1.23.6   192.168.100.171   <none>        Ubuntu 22.04.3 LTS   5.15.0-88-generic   docker://24.0.7
    k8spps2   Ready    <none>                 107s   v1.23.6   192.168.100.172   <none>        Ubuntu 22.04.3 LTS   5.15.0-88-generic   docker://24.0.7
    k8spps3   Ready    <none>                 107s   v1.23.6   192.168.100.173   <none>        Ubuntu 22.04.3 LTS   5.15.0-88-generic   docker://24.0.7
    ```

9. Comprobamos acceso al Dashboard:

    ```sh
    labredes@k8spps1:~$ kubectl proxy --address='192.168.100.171'
    Starting to serve on 192.168.100.171:8001
    ```

    ERROR! Acá tengo "Forbidden" tanto haciendo curl desde la misma vpc, como accediendo remotamente vía navegador.

10. Comenzamos a probar las configuraciones de Kubeflow:

    1. Seguí todas los pasos de la rama act_8_kubeflow
    2. Puerto 80:

      ```sh
      kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
      ```
