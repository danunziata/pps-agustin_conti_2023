# How To

## Entorno de laboratorio con Kubernetes (k8s)

1. Levantamos el cluster de Kubernetes con las 3 máquinas.

   - Las máquinas virtuales:

   ```sh
   vagrant up
   ```

   - Nos aseguramos que en `ansible/roles/install_kubernetes_dependencies/tasks/main.yml` la versión de los paquetes sea la que sigue:

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

- Configuramos k8s:

   ```sh
   ansible-playbook -vvv ansible/site.yml -i ansible/inventory.yml
   ```

- Checkeamos que esten los 3 nodos levantados:

    ```sh
    ssh -i ~/.ssh/vagrant_key vagrant@192.168.55.51
    vagrant@k8s-1 $ kubectl get nodes
    ```

- Ejecutamos este comando para que funcione la API:

  ```sh
  kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous
  ```

1. Nos aseguramos que en las 3 tengamos instalado lvm2:

   ```sh
   sudo apt -y install lvm2
   ```

2. En el `control-plane node` creamos una carpeta `rook` y dentro de ella clonamos el repositorio siguiente:

   ```sh
   mkdir rook
   cd rook
   git clone --single-branch --branch release-1.5 https://github.com/rook/rook.git
   ```

3. Instalamos rook en el `control-plane node`:

   ```sh
   cd rook/cluster/examples/kubernetes/ceph/
   kubectl create -f crds.yaml -f common.yaml -f operator.yaml
   ```

   Checkeamos que el pods se haya levantado correctamente (veremos una actualización cada dos segundos del get pods, esperamos a que todos esten en estado Running):

   ```sh
   watch kubectl get pods -A
   ```

   Deberíamos ver lo siguiente:

   ```sh
    NAMESPACE              NAME                                         READY   STATUS    RESTARTS        AGE
    kube-system            calico-kube-controllers-57c6dcfb5b-9x8kp     1/1     Running   1 (5m58s ago)   8m12s
    kube-system            calico-node-4dtgw                            1/1     Running   2 (4m39s ago)   8m6s
    kube-system            calico-node-9hrw7                            1/1     Running   1 (5m58s ago)   8m12s
    kube-system            calico-node-jkk7x                            1/1     Running   0               4m4s
    kube-system            coredns-64897985d-9l6gj                      1/1     Running   1 (5m53s ago)   8m12s
    kube-system            coredns-64897985d-vmpxc                      1/1     Running   1 (5m53s ago)   8m12s
    kube-system            etcd-k8s-1                                   1/1     Running   2 (5m1s ago)    8m25s
    kube-system            kube-apiserver-k8s-1                         1/1     Running   2 (5m1s ago)    8m28s
    kube-system            kube-controller-manager-k8s-1                1/1     Running   2 (5m2s ago)    8m27s
    kube-system            kube-proxy-58vtl                             1/1     Running   0               4m4s
    kube-system            kube-proxy-6cjq2                             1/1     Running   1 (5m58s ago)   8m12s
    kube-system            kube-proxy-cq7pt                             1/1     Running   2 (4m39s ago)   8m6s
    kube-system            kube-scheduler-k8s-1                         1/1     Running   2 (5m2s ago)    8m25s
    kubernetes-dashboard   dashboard-metrics-scraper-799d786dbf-phk8j   1/1     Running   1 (5m58s ago)   8m12s
    kubernetes-dashboard   kubernetes-dashboard-546cbc58cd-tlnml        1/1     Running   1 (5m58s ago)   8m12s
    rook-ceph              rook-ceph-operator-5b5f4c878-m76mz           1/1     Running   0               2m2s
   ```

4. Creamos el cluster en el `control-plane node`:

    ```sh
    kubectl create -f cluster-test.yaml
    ```

    Validamos la instalación (veremos una actualización cada dos segundos del get pods, esperamos a que todos esten en estado Running):

    ```sh
    watch kubectl get pods -n rook-ceph
    ```

5. Aprovisionamos una Storage Class:

   ```sh
    cd csi/rbd/
    kubectl apply -f storageclass-test.yaml
   ```

   Checkeamos que se haya aprovisionado correctamente:

   ```sh
   kubectl get sc
   ```

   Deberíamos ver lo siguiente:

   ```sh
    NAME              PROVISIONER                  RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
    rook-ceph-block   rook-ceph.rbd.csi.ceph.com   Delete          Immediate           true                   73s
   ```

6. Convertimos la SC en Default:

    ```sh
    kubectl patch sc rook-ceph-block -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    ```

    Debería figurarnos el siguiente mensaje:

    ```sh
    storageclass.storage.k8s.io/rook-ceph-block patched
    ```

    Checkeamos que esté por Default:

    ```sh
    kubectl get sc
    ```

    Deberíamos ver lo siguiente:

    ```sh
    NAME                        PROVISIONER                  RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
    rook-ceph-block (default)   rook-ceph.rbd.csi.ceph.com   Delete          Immediate           true                   5m19s
    ```

7. Ahora vamos a instalar Kubeflow desde los `manifests`, para ello, nos dirigimos a la [página de Kubeflow](https://v1-5-branch.kubeflow.org/docs/started/installing-kubeflow/) en su versión 1.5 y luego entramos al link de [GitHub](https://github.com/kubeflow/manifests/tree/v1.5-branch) donde se encuentran los manifests.

8. Necesitamos instalar en nuestro `control-plane node` la versión 3.2.0 de Kustomize:
    - Descargamos el binario:

    ```sh
    cd ~
    wget https://github.com/kubernetes-sigs/kustomize/releases/download/v3.2.0/kustomize_3.2.0_linux_amd64 -O kustomize
    ```

    - Instalamos:

    ```sh
    sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize
    ```

    - Checkeamos versión:

    ```sh
    kustomize version
    ```

    Deberíamos ver lo siguiente:

    ```sh
    Version: {KustomizeVersion:3.2.0 GitCommit:a3103f1e62ddb5b696daa3fd359bb6f2e8333b49 BuildDate:2019-09-18T16:26:36Z GoOs:linux GoArch:amd64}
    ```

9. Clonamos el repositorio de los manifests:

    ```sh
    git clone --branch v1.5-branch https://github.com/kubeflow/manifests.git
    cd manifests
    ```

10. Dentro de la carpeta de dicho repositorio, aplicamos el siguiente comando para intalar todo:

    ```sh
    while ! kustomize build example | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done
    ```

11. Esperamos a que se ejecute todo y vamos a checkear que se hayan levantado todos los pods correspondientes:

    ```sh
    kubectl get pods -n cert-manager
    kubectl get pods -n istio-system
    kubectl get pods -n auth
    kubectl get pods -n knative-eventing
    kubectl get pods -n knative-serving
    kubectl get pods -n kubeflow
    kubectl get pods -n kubeflow-user-example-com
    ```

    El que más nos importa ver que esté correiendo correctamente es:

    ```sh
    watch kubectl get pods -n kubeflow
    ```

    Donde cuando veamos que están todos los pods corriendo, nos fijaremos si se levantaron los pods correspondientes al ejemplo:

    ```sh
    watch kubectl get pods -n kubeflow-user-example-com
    ```

12. Hacemos la exposición de los puertos para poder acceder a la interfaz gráfica de Kubeflow:

    ```sh
    kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
    ```

    ERROR! No funciona, es Forbidden tanto haciendo CURL desde adentro de la VPC Master como desde la PC HOST.

## Problemas que detecté y "resolví"

1. Corregir la IP de los hosts.

    Cuando aplicamos el siguiente comando:

    ```sh
    kubectl get nodes -o wide
    ```

    Notamos que la IP interna (`Internal IP`) no es la correspondiente a la red privada, sino a la de la NAT. Para corregir esto tenemos que modificar el role de Ansible que hace la instalación de los componentes:

    ```sh
    vi k8s/ansible/roles/install_kubernetes_dependencies/tasks/main.yml
    ```

    Donde descomentamos la siguiente sección y le agregamos `create: yes`:

    ```yaml
    - name: Configure node IP
      lineinfile:
        path: /etc/default/kubelet
        line: "KUBELET_EXTRA_ARGS=--node-ip={{ ansible_host }}"
        create: yes
    ```

    Ya que al no existir dicho archivo, se creaba un conflicto, por ende debíamos crearlo para que luego sea usado en las configuraciones y no tome las IP por defecto (que corresponden a las de la interfaz de la NAT).

2. Corregir el estado de los componentes.

    Cuando aplicamos el siguiente comando:

    ```sh
    kubectl get componentstatuses
    ```

    Tenemos un error que nos dice `Unhealthy` en los componentes de `controller-manager` y `scheduler` que dice que la conexión fue rechazada: `dial 128.0.0.1:1025n connect: onnection refused`. Para solucionar este problema debemos seguir los siguientes pasos:

      - Comentar la linea `- --port=0`  en (spec->containers->command) del siguiente archivo:

        ```sh
        sudo vi /etc/kubernetes/manifests/kube-scheduler.yaml
        ```

      - Comentar la linea `- --port=0`  en (spec->containers->command) del siguiente archivo:

          ```sh
          sudo vi /etc/kubernetes/manifests/kube-controller-manager.yaml
          ```

      - Reiniciar el servicio de Kubelet:

          ```sh
          sudo systemctl restart kubelet.service
          ```

        Ahora el output del comando debería ser el siguiente:

          ```sh
          vagrant@k8s-1:~$ kubectl get componentstatuses
          Warning: v1 ComponentStatus is deprecated in v1.19+
          NAME                 STATUS    MESSAGE             ERROR
          scheduler            Healthy   ok                  
          controller-manager   Healthy   ok                  
          etcd-0               Healthy   {"health":"true"}  
          ```

## Referencias

[YouTube - Setting up a Local Kubernetes cluster on bare metal Ubuntu workstations](https://www.youtube.com/watch?v=nw8OxozYstk)

[YouTube - Deploying a local Kubeflow setup (Part-2)](https://www.youtube.com/watch?v=5E-r_0MGZ20)

[Error - Kubernetes cluster access](https://stackoverflow.com/questions/45094665/user-systemanonymous-cannot-get-path)

[Error - Kubectl Node IP](https://stackoverflow.com/questions/58892994/destination-etc-default-kubelet-does-not-exist)

[Error - Kubectl Component Statuses](https://stackoverflow.com/questions/64296491/how-to-resolve-scheduler-and-controller-manager-unhealthy-state-in-kubernetes)
