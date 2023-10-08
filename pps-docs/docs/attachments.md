# PPS MLOps

## Anexo

### Semantic Releases

[How to Manage Releases with Semantic Versioning and Git Tags](https://www.youtube.com/watch?v=4wPjo5C-v8Y)

#### ¿Qué es una ‘release’?

Una release es empaquetar cualquier cambio en el código y enviarlo a producción. Por ejemplo, un cambio de nuestra página web que vaya al público y no a nuestra etapa de desarrollo.

El manejo de estas releases puede ser un poco complicado, especialmente si no seguimos un cierto standard. Por eso es que usamos ‘semantic versioning’ con git tags para manejar de manera fácil nuestras releases.

#### ¿Qué es el ‘semantic versioning’?

El semantic versioning es sólo un esqueman numérico, es una práctica estándar de la industria del software que sirve para indicar el “grado de cambios” que se han hecho desde la release de producción anterior. Todos usan semantic versioning, desde Git, hasta Firefox y los SO como iOS.

#### ¿Qué estructura tiene la semantic versioning?

Tiene 3 partes:

```
MAJOR.MINOR.PATCH
```

Cada una de las partes indica algo diferente cuando incrementa:

- **Major:** Cuando vamos de 1.0.0 a 2.0.0 indicamos que cambiamos de manera disruptiva, incluimos cambios que no sean compatibles hacia atrás, etc. Por ejemplo, remover código que ya no sirve para incluir una reestructuración completa de la arquitectura de nuestra aplicación.

- **Minor:** Cuando vamos de 1.0.1 a 1.1.0 indicamos que cambiamos funcionalidades, pero que estos cambios son compatibles hacia atrás. Puede ser el cambio de una funcionalidad, la actualización de una, el agregado de otra.

- **Patch:**  Cuando vamos de 1.0.1 a 1.0.2 indicamos arreglos de bugs y actualizaciones triviales.

#### Premisas del semantic version

- Una vez hecha una release, la versión no puede ser cambiada
- Si nos olvidamos algo no podemos “retaggear” una versión, estos deberían entrar en una nueva release.
- Somos responsables de checkear reiteradamente la versión actual antes de hacer un release.

#### Git Tagging ¿Qué es un Tag?

Es una manera de agregar un marcador o marker a un commit para indicar que es importante de alguna manera en nuestro repositorio. Hay dos diferentes tipos de GitTags:

- **Lightweigh tags:** Un puntero con nombre básico para un commit.
    
    ```
    > git tag <tag-name> [commit]
    ```    

- **Annotated tags:** Un objeto completo en la database de git verificado, contiene información de el tag, tiene un mensaje de taggeo (tagging message) y puede ser firmada y verificada con GNU Privacy Guard (GPG). Esta última es la que se recomienda usar.
    
    ```
    > git tag -a <tag-name> -m"<annotation>" [commit]
    ```
    
Tanto el semantic versioning como el GitTagging van de la mano, podemos agregar un commit taggeando la versión correspondiente.
#### Semantic versioning + Annotated Tags = Semantic Releases

Nos permite tener commits marcados en nuestro repositorio de git con una versión específica. Los beneficios de esto en un repositorio de git son:

- Le da significado a los cambios importantes en nuestro repositorio.
- Comunica el “grado de cambio” entre los diferentes tags.
- Vemos de manera directa el historial de tracking de los cambios realizados.

#### Esto está soportada por:

- Diferentes interfaces de Git, como Git Kraken o GitHub Desktop.
- Diferentes herramientas de automatización como Circle CI, Bitbucket, Travis, etc.

#### ¿Cómo creo las ‘Semantic Git Releases2?

Es un proceso que consiste en 3 pasos:

1. Crear un annotated tag
    1. Usar semantic versioning para el nombre del tag
    2. Brindar una annotation
2. Pushear el tag al repositorio remoto
3. Insertar los pasos de deployment acá

Crear una un semantic release tag usando la consola:

```
> git tag -a v1.0.0 -m "release 1.0.0"
> git push <remote> v1.0.0
```

#### Release Notes

Tenemos que evitar las anotaciones mínimas. Se recomienda, para cada tipo de release:

- **Patch:** Lista de los bug fixes
- **Minor:** Lista de cambios, detalles de uso.
- **Major:** Lista de elementos removidos, lista de cosas agregadas, proceso de actualización.

**Tomar una lista de los mensajes de los commits entre releases:**

```
git log --pretty=format:%s <last release>... HEAD --no-merges

git tag -a <tag-name> -m"$(git log --pretty=format:%s <last release>... HEAD --no-merges)"
```

#### ¿Cómo automatizo la generación de los tags?

- Puedo buscar en el mercado por alguna herramienta de automatización.
- Crear un script de bash por nosotros mismos para ayudarnos a automatizar los pasos repetitivos.

[semtag-generator](https://github.com/mikemiles86/semtag-generator)

### Git Workflow

[](https://medium.com/@patrickporto/4-branching-workflows-for-git-30d0aaee7bf)

Los Git Workflows son metodologías de trabajo para los usuarios de de Git.  

#### Git Flow

Es el workflow más conocido, basado en dos branches principales que son perpetuas, con vida infinita. Estas son:

- **master:** Tiene el código de producción. Todo el código de desarrollo es ‘mergeado’ dentro de la branch master en algún momento.
- **develop:**  Contiene el código de pre-producción. Cuando las modificacioens o nuevas características estén finalizadas, se ‘mergean’ en la branch develop.

Durante el ciclo de desarrollo, una variedad de ramas de soporte son utilizadas:

- **feature-*:** Usada para desarrollar nuevas caracterísitcas que vendrán en las futuras releases. Debería desprenderse de la rama develop y mergearse en la rama develop.
- ***hotfix-*:** Son necesarias para actuar inmediatamente ante un estado indeseado de la branch master. Debería desprenderse de la branch master y mergearse tanto en máster como en develop.
- **release-*:** Son la preparación de una nueva release de producción. Permiten que haya menos bugs que arreglar y la preparación de la metadata para la release. Debe desprenderse de la rama develop y debe ser mergeada en la rama master y develop.

#### GitHub Flow

[GitHub flow - GitHub Docs](https://docs.github.com/en/get-started/quickstart/github-flow)

Es un workflow liviano creado por GitHub y se basa en 6 principios:

1. Todo en la rama **master** es deployable.
2. Para trabajar en algo nuevo, creamos una rama desde la master con un nombre descriptivo.
3. Hacemos commit a esa rama localmente y regularmente hacemos push del trabajo a la misma rama en remoto.
4. Cuando necesitamos feedback o creemos que es necesario mergear, abrimos un Pull Request (PR).
5. Despues de que alguien haya revisado y firmado la nueva característica, se puede hacer merge en la master.
6. Una vez hecho el merge y pusheado a la rama master, debemos deployar inmediatamente.

#### GitLab Flow

Es un workflow creado por GitLab. Combina un desarrollo dirigido por las funcionalidades (caracteristicas) y con ramas de funcionalidades con un trackeo de problemas.

La mayor diferencia con GitHub Flow es el ambiente de las ramas que tenemos en GitLab Flow (staging y production) porque será un proyecto que no puede deployarse en producción cada vez que hacemos un merge de una nueva feature branch. Se basa en 11 principios:

1. Usa feature branches, no commits directos a master.
2. Prueba todos los commits, no solo los de la master.
3. Corre todos los test en todos los commits.
4. Hacer revisión de codigo antes de hacer el merge en master.
5. Los deployments son automáticos, basados en las branches o tags.
6. Los tags son configurados por el usuario, no por el CI.
7. Las releases son basadas en tags.
8. Los commits ya pusheados nunca son rebasados.
9. Todos comienzan por master y apuntan a master.
10. Corregir bugs en master primero, release branches segundo.
11. Los commits reflejan la intención.

#### ¿Cual elegimos?

Por simplicidad y por la plataforma en la que estamos trabajando el workflow más conveniente será **GitHub Workflow**.

### ¿Qué es Vagrant?

Vagrant es una herramienta que podés usar para crear y gestionar entornos de desarrollo virtualizados de manera fácil y reproducible. Su uso típico es facilitar la creación de máquinas virtuales con configuraciones específicas para el desarrollo de proyectos.

Para comenzar un proyecto de Vagrant en el directorio /vagrant, el usuario puede seguir estos pasos:

1. **Instalación de Vagrant:**
Antes que nada, necesitás instalar Vagrant en tu máquina. Esto se puede hacer descargando el instalador desde el sitio oficial y siguiendo las instrucciones.
2. **Creación de un archivo Vagrantfile:**
En el directorio donde querés iniciar el proyecto, creá un archivo llamado `Vagrantfile`. Este archivo contendrá la configuración de la máquina virtual, como el sistema operativo, la cantidad de memoria RAM, etc.
3. **Configuración del Vagrantfile:**
Dentro del Vagrantfile, especificá la configuración deseada. Por ejemplo, podés elegir un sistema operativo base, asignar recursos como CPU y RAM, y configurar la red.
4. **Inicialización de la máquina virtual:**
Ejecutá el comando `vagrant up` en el directorio donde se encuentra el Vagrantfile. Este comando creará y provisionará la máquina virtual según la configuración especificada.
5. **Acceso a la máquina virtual:**
Utilizá el comando `vagrant ssh` para acceder a la máquina virtual recién creada. Esto abrirá una conexión SSH a la máquina virtual.

Algunas ventajas clave de utilizar Vagrant para levantar múltiples entornos de desarrollo son:

- **Reproducibilidad:** Con Vagrant, se puede garantizar que todos los miembros del equipo tengan exactamente el mismo entorno de desarrollo, evitando problemas de compatibilidad.
- **Portabilidad:** Los entornos Vagrant son independientes de la máquina host, lo que significa que podés compartir el mismo entorno de desarrollo en diferentes sistemas operativos.
- **Aislamiento:** Cada proyecto puede tener su propio entorno virtualizado, evitando conflictos entre dependencias y facilitando la gestión de versiones de software.
- **Eficiencia en el uso de recursos:** Vagrant permite ejecutar varias máquinas virtuales de manera eficiente, lo que es útil para simular entornos complejos, como redes privadas virtuales (VPNs) o arquitecturas de microservicios.

### Ejemplo de una Vagrantfile

Crearemos un entorno de 3 máquinas, una master y 2 nodos a los cuales les aplicaremos configuraciones generales y particulares a cad auno. Importante aclarar que usaremos una imagen distinta a la vista antes, en este caso será `ubuntu/trusty64`.

**¡Importante!** Para poder configurar cierta red privada deberemos crear o modificar el archivo `/etc/vbox/networks.conf` añadiendo la red de la siguiente manera:

```ruby
sudo su
echo "* 0.0.0.0/0" > networks.conf
```

**Primero vamos a crear las claves públicas y privadas para las conexiones SSH:**

Creamos nuestra propia clave pública y privada con `ssh-keygen`, procuramos no poner passphrase para que no se la solicite a las VMs a la hora de iniciarlas.

```bash
# ~/.ssh/
> ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (/home/aagustin/.ssh/id_rsa): vagrant_key
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in vagrant_key
Your public key has been saved in vagrant_key.pub
The key fingerprint is:
SHA256:K4v2o7EKOLfjCMLk7zVD4v234234c06peueU aagustin@hp-agustin
The key's randomart image is:
+---[RSA 4096]----+
|                 |
|                 |
|                 |
|                 |
| . . . .S     .  |
|= . 3 o ..   o.. |
|*o.+.*.... +.++. |
|o=o.B4==  . *++  |
|..=*+*=++ .+o. E |
+----[SHA256]-----+
```

**Ahora si, escribimos el archivo Vagrantfile:**

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
    
  # Image configuration (for all vm's)
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.box_version = "202309.08.0"
  
  # SSH (for all vm's)
  config.ssh.insert_key = false
  config.ssh.forward_agent = true  
  config.ssh.private_key_path = ["/home/aagustin/.vagrant.d/insecure_private_key","/home/aagustin/.ssh/vagrant_key"]     
  config.vm.provision "file", source: "/home/aagustin/.ssh/vagrant_key.pub", destination: "/home/vagrant/.ssh/authorized_keys"

  # Declaring master node and defining it like a primary machine
  config.vm.define "master", primary: true do |master|
    
    # Resources (provider)
    master.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "trusty64-master"
      vb.memory = "2048"
      vb.cpus = "2"
    end

    # Configure synced folder
    #config.vm.synced_folder "~/my-loc/vagrant/synced/folders/master/", "/home/vagrant/"

    # Network configuration
    master.vm.network "public_network",
      bridge:"wlo1",
      ip: "192.168.102.102",
      netmask: "255.255.255.0"
    
    master.vm.network "private_network",
      ip: "192.168.55.2",
      netmask: "255.255.255.0",
      auto_config: false
    
    master.vm.network "forwarded_port",
      guest: 80,
      host: 31002
      
    # SSH
    master.ssh.host = "127.0.0.2"
    master.vm.network "forwarded_port",
      guest: 22,
      host: 2222,
      host_ip:"0.0.0.0",
      id: "ssh",
      auto_correct: true
    
    # Provisioning message
    master.vm.provision "shell",
      inline: "echo Hello master"
  end

  # Declaring secondary nodes (iteratively)
  (1..2).each do |i|
    config.vm.define "node-#{i}" do |node|
      
      # Resources (provider)
      node.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.name = "trusty64-node-#{i}"
        vb.memory = "2048"
        vb.cpus = "2"
      end

      # Configure synced folder
      #config.vm.synced_folder "~/my-loc/vagrant/synced/folders/node-#{i}/", "/home/vagrant/"

      # Network configuration
      node.vm.network "public_network",
        bridge:"wlo1",
        ip: "192.168.102.10#{2+i}",
        netmask: "255.255.255.0"
      
      node.vm.network "private_network",
        ip: "192.168.55.#{2+i}",
        netmask: "255.255.255.0",
        auto_config: false
      
      node.vm.network "forwarded_port",
        guest: 80,
        host: 31002+i

      # SSH
      node.ssh.host = "127.0.0.#{2+i}"
      node.vm.network "forwarded_port",
        guest: 22,
        host: 2222+i,
        host_ip:"0.0.0.0",
        id: "ssh",
        auto_correct: true
           
      # Provisioning message
      node.vm.provision "shell", inline: "echo Hello node-#{i}"
    end      
  
  end

end
```

Notar que en la línea `config.ssh.private_key_path = ["/home/aagustin/.vagrant.d/insecure_private_key","/home/aagustin/.ssh/vagrant_key"]` ponemos dos opciones, lo que logramos con esto es que use primero la por default y luego de lograda la conexión ya configura la clave pública, entonces podemos acceder con la clave propia la próxima vez. Además es importante que esté desactivada la generación por defecto de nuevas claves así se usa la genérica, por eso tenemo la línea `config.ssh.insert_key = false`.

**Levantamos nuestra configuración:**

Podemos hacer `vagrant up` y por ultimo veremos el estado de estas con:

```bash
$ vagrant status
Current machine states:

master                    running (virtualbox)
node-1                    running (virtualbox)
node-2                    running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

**Nos conectamos con las VPCs:**

Podemos acceder con SSH mediante:

```bash
ssh -p [puerto-vpc] vagrant@[ip-vpc] -i [ubicacion-priv-key]
```

Una vez hecha la conexión SSH, podemos ver la configuración de la red que le hemos establecido a dicha máquina virtual:

```bash
vagrant@vagrant:~$ ip -brief -c a
lo               UNKNOWN        127.0.0.1/8 ::1/128 
eth0             UP             10.0.2.15/24 metric 100 fe80::a00:27ff:fe3b:cf90/64 
eth1             UP             192.168.102.102/24 fe80::a00:27ff:fe3b:4c8d/64 
eth2             UP             192.168.55.2/24 fe80::a00:27ff:fef5:3997/64
```

**Levantamos un servicio de prueba:**

Podemos checkear el correcto funcionamiento de la IP pública y el port forwarding levantando un servicio con python en el puerto 80 de nuestra vPc:

```bash
sudo python3 -m http.server 80
```

Y luego, podemos acceder desde el navegador de la máquina host o cualquier navegador de cualquier dispositivo que esté conectado a la misma red local:

![Untitled](source/vagrant-service-1.png)

![Untitled](source/vagrant-service-2.png)