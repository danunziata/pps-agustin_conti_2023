# How To

## Entorno de laboratorio con Kubernetes (k8s)

### Requerimientos

- Según el video:

  - Máquinas virtuales
    - SO: Ubuntu 22.04
    - CPU: 4
    - RAM: 2
    - STORAGE: 50 GB
    - GPU: ?
  - Kubernetes
    - Versión:
    - Nodos: control-plane y worker

- Según la documentación de Kubeflow y el repositorio de RAW Manifests de Kubeflow:

  - Máquinas virtuales
    - SO: ?
    - CPU: ?
    - RAM: ?
    - STORAGE: ?
    - GPU: ?
  - Kubernetes
    - Nodos: ?
    - Kubernetes (up to 1.26) with a default StorageClass
    - kustomize 5.0.3
    - kubectl

### Inicialización de las máquinas virtuales

1. Levantamos las PCs de Vagrant con las configuraciones establecidas en los requerimientos:

    ```sh
    vagrant up
    ```

    Para eliminarlas:

    ```sh
    vagrant destroy
    ```

### Configuración de Kubernetes

2. En el `control-plane node` inicializamos la configuración de Kubernetes:

    ```sh
    kubeadm init --pod-network-cidr 10.244.0.0/22 --control-plane-endpoint 192.168.55.51:6443 --apiserver-advertise-address 192.168.55.51 --apiserver-cert-extra-sans 192.168.55.51
    ```

    Como vemos nos aseguramos que el CIDR que le asignamos no haga conflicto con la red local y además le especificamos la IP y el puerto en el que queremos la API de Kubernetes, por último definimos los nombres alternativos de asunto (SAN) adicionales opcionales que se utilizarán para el certificado de servidor de API.

3. En el `control-plane node` creamos las carpertas correspondientes y copiamos los archivos de configuración:

    ```sh
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    ```

4. Guardamos el comando de join que nos brinda:

    ```sh
    kubeadmn join 192.168.55.51  -token ... -discovery-token-ca-cert-hash ...
    ```

5. En el `control-plane node` checkeamos que tenemos el nodo levantado:

    ```sh
    kubectl get nodes
    ```

6. En el `control-plane node` aplicamos las configuraciones de red `calico.yaml`:

    ```sh
    kubectl apply -f calico.yaml
    ```

7. En el `control-plane node` checkeamos que se hayan levantado los pods correspondientes a calico:

    ```sh
    kubectl get pods --all-namespaces
    ```

8. Una vez que veamos que todos los pods estén en estado `Running`, podemos configurar el `worker node`, en el cual pegaremos el comando del join token que obtuvimos anteriormente del control-plane node:

    ```sh
    sudo kubeadmn join 192.168.55.51  -token ... -discovery-token-ca-cert-hash ...
    ```

    Importante ejecutar con privilegios `sudo`.

9. Nos aseguramos desde el `control-plane node` que el worker node se haya asociado correctamente al contro-plane:

    ```sh
    kubectl get nodes
    ```

10. Para Kubeflow necesitamos un dynamic provisioner, para el cual usaremos un Built in local persistent volume feature para Kubernetes llamado `Rancher`, entonces desde el `control-plane node`:

    ```sh
    kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

    ```

11. Checkeamos que el pod se haya levantado correctamente, en el `contro-plane node` ejecutamos:

    ```sh
    kubectl -n local-path-storage get pod -o wide
    ```

    Debemos verificar que esté corriendo en el `worker node` y que tenga una IP del CIDR asignada.

12. Checkeamos que tenemos una storage class, ejecutando lo siguiente en el `control-plane node`:

    ```sh
    kubectl get sc
    ```

    Deberíamos ver algo relacionado a rancher y como atributo NAME tendríamos `local-path`.

13. Como el storage class anterior no está por defecto, necesitamos ponerlo por defecto, para ello ejecutamos lo siguiente en el `control-plane node`:

    ```sh
    kubectl patch storageclass local-path -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    ```

14. Checkeamos que se haya configurado como default, ejecutamos en el `control-plane node`:

    ```sh
    kubectl get sc
    ```

    Debería figurar como `(default)` al lado del NAME `local-path`.

## Instalación de Kubeflow

Una vez tenemos nuestro entorno de laboratorio, podemos empezar a instalar Kubeflow.

[Install with RAW manifests](https://github.com/kubeflow/manifests#prerequisites)

15.

## Prueba en nuestro entorno: k8s aprovisionado con Ansible

En nuestro caso, como usamos Ansible para el aprovisionamiento de k8s, tenemos resuelto los pasos hasta el paso 9. Por ende, arrancando del paso 10 en adelante.

Lo único que nos tenemos que asegurar es de darle los suficientes recursos a los nodos. En nuestro caso, crearemos solo 2.

Además, para el aprovisionamiento con Ansible, deberemos recordar eliminar del inventario la línea correspondiente a la declaración del tercer nodo en `ansible/inventory.yml`.

Luego ya, podemos aprovisionar:

```sh
ansible-playbook -vvv ansible/site.yaml -i ansible/inventory.yml
```

Con lo cual, si todo salió como corresponde deberíamos tener algo como esto al final de la ejecución:

```sh
PLAY RECAP **********************************************************************************************
k8s-1                      : ok=31   changed=25   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
k8s-2                      : ok=21   changed=16   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

Entonces, ahora accederemos por SSH al `control-plane node`:

```sh
ssh -i ~/.ssh/vagrant_key vagrant@192.168.55.51
```

Checkeamos la versión de Kubectl instalada:

```sh
vagrant@k8s-1:~$ kubectl version
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.6", GitCommit:"ad3338546da947756e8a88aa6822e9c11e7eac22", GitTreeState:"clean", BuildDate:"2022-04-14T08:49:13Z", GoVersion:"go1.17.9", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.17", GitCommit:"953be8927218ec8067e1af2641e540238ffd7576", GitTreeState:"clean", BuildDate:"2023-02-22T13:27:46Z", GoVersion:"go1.19.6", Compiler:"gc", Platform:"linux/amd64"}
```

Vemos que cumplimos con que nuestra versión del cliente sea menor o igual a la 1.26.

Checkeamos que tenemos los nodos levantados:

```sh
vagrant@k8s-1:~$ kubectl get nodes
NAME    STATUS   ROLES                  AGE     VERSION
k8s-1   Ready    control-plane,master   6m16s   v1.23.6
k8s-2   Ready    <none>                 5m53s   v1.23.6
```

Ahora sí, estamos en condiciones de a empezar a partir del paso 10.

10. Ejecutamos la configuración del dynamic storage provisioner:

    ```sh
    vagrant@k8s-1:~$ kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
    namespace/local-path-storage created
    serviceaccount/local-path-provisioner-service-account created
    role.rbac.authorization.k8s.io/local-path-provisioner-role created
    clusterrole.rbac.authorization.k8s.io/local-path-provisioner-role created
    rolebinding.rbac.authorization.k8s.io/local-path-provisioner-bind created
    clusterrolebinding.rbac.authorization.k8s.io/local-path-provisioner-bind created
    deployment.apps/local-path-provisioner created
    storageclass.storage.k8s.io/local-path created
    configmap/local-path-config created
    ```

11. Checkeamos que esté corriendo en el `worker node`.

    ```sh
    vagrant@k8s-1:~$ kubectl -n local-path-storage get pod -o wide
    NAME                                     READY   STATUS    RESTARTS   AGE   IP               NODE    NOMINATED NODE   READINESS GATES
    local-path-provisioner-dbd774c5c-7jlzh   1/1     Running   0          97s   10.244.200.193   k8s-2   <none>           <none>
    ```

    Vemos que el CIDR es adecuado y que está en estado `Running`.

12. Checkeamos que se haya creado el storage class:

    ```sh
    vagrant@k8s-1:~$ kubectl get sc
    NAME         PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
    local-path   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  6m53s
    ```

13. Configuramos la sc como default:

    ```sh
    vagrant@k8s-1:~$ kubectl patch storageclass local-path -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    storageclass.storage.k8s.io/local-path patched
    ```

14. Checheamos que figure como default:

    ```sh
    vagrant@k8s-1:~$ kubectl get sc
    NAME                   PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
    local-path (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  8m46s
    ```

Ahora podríamos arrancar con la instalación de Kubeflow. Para ello seguimos los pasos que figuran en el repositorio de los RAW manifest.

1. Necesitamos instalar Kustomize, para ello descargamos los binarios de su página con curl:

    ```sh
    vagrant@k8s-1:~$ curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
    v5.2.1
    kustomize installed to /home/vagrant/kustomize
    ```

    Instalamos:

    ```sh
    vagrant@k8s-1:~$ sudo install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize
    ```

    Checkeamos la versión instalada:

    ```sh
    vagrant@k8s-1:~$ kustomize version
    v5.2.1
    ```

    Observamos que también cumplimos con la versión mínima requerida.

2. Clonamos el repositorio `manifests` dentro del `control-plane node`:

    ```sh
    vagrant@k8s-1:~$ git clone https://github.com/kubeflow/manifests.git
    Cloning into 'manifests'...
    ```

3. Ingresamos al repositorio:

    ```sh
    cd manifests
    ```

4. Instalamos Kubeflow con un single-command:

    ```sh
    while ! kustomize build example | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done
    ```

      a. Problemas:

        ```sh
        kustomize build common/oidc-client/oidc-authservice/base | kubectl apply -f -
        # Warning: 'vars' is deprecated. Please use 'replacements' instead. [EXPERIMENTAL] Run 'kustomize edit fix' to update your Kustomization automatically.
        ```

5. Checkeamos que todos los pods estén listos luego de la instalación:

    ```sh
    kubectl get pods -n cert-manager
    kubectl get pods -n istio-system
    kubectl get pods -n auth
    kubectl get pods -n knative-eventing
    kubectl get pods -n knative-serving
    kubectl get pods -n kubeflow
    kubectl get pods -n kubeflow-user-example-com
    ```

6. Hacemos forward del puerto 8080 para poder acceder:

    ```sh
    kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
    ```

7. Accedemos al Dashboard central mediante la url:

    ```http
    http://192.168.55.51:8080
    ```

8. Nos loggeamos utilizando el usuario `user@example.com` y la contraseña `12341234`.

9. Configuramos nuestro propio usuario y contraseña:

    a. Pick a password for the default user, with email <user@example.com>, and hash it using bcrypt:

      ```sh
      python3 -c 'from passlib.hash import bcrypt; import getpass; print(bcrypt.using(rounds=12, ident="2y").hash(getpass.getpass()))'
      ```

    b. Edit `common/dex/base/config-map.yaml` and fill the relevant field with the hash of the password you chose:

      ```yaml
      ...
        staticPasswords:
        - email: user@example.com
          hash: <enter the generated hash here>
      ```

## Referencias

[The Null Channel - basic kubeflow and kubernetes install](https://www.youtube.com/watch?v=8BSbpJc8FTw)

[Kustomize - Download binaries](https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/)
