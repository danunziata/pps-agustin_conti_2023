# Desarrollo

## Comparación

**Kubeflow** ofrece una forma escalable de entrenar y desplegar modelos en Kubernetes. Es un medio de orquestación que permite que un framework de aplicaciones en la nube funcione sin problemas. Algunos de los componentes de Kubeflow son los siguientes:

* **Notebooks:** Ofrece servicios para crear y gestionar cuadernos Jupyter interactivos en entornos corporativos. También incluye la posibilidad de que los usuarios construyan contenedores de Notebooks o pods directamente en clusters.

* **Entrenamiento de modelos de TensorFlow:** Kubeflow viene con un "job operator" de TensorFlow personalizado que facilita la configuración y ejecución del entrenamiento de modelos en Kubernetes. Kubeflow también admite otros frameworks mediante job operators a medida, pero su madurez puede variar.

* **Pipelines:** Los pipelines de Kubeflow permiten construir y gestionar flujos de trabajo de aprendizaje automático de múltiples pasos que se ejecutan en contenedores Docker.

* **Despliegue:** Kubeflow ofrece varias formas de desplegar modelos en Kubernetes a través de complementos externos.

**MLflow** es un framework de código abierto para el seguimiento de todo el ciclo de aprendizaje automático de principio a fin, desde la formación hasta la implementación. Entre las funciones que ofrece se encuentran el seguimiento de modelos, la gestión, el empaquetado y las transiciones centralizadas de etapas del ciclo de vida. Algunos de los componentes de MLflow son los siguientes:

* **Seguimiento:** Mientras ejecutas tu código de aprendizaje automático, hay una API y una interfaz de usuario para registrar parámetros, versiones de código, métricas y archivos de salida para que puedas visualizarlos más tarde.

* **Proyecto:** Proporcionan un estilo estándar para empaquetar código de ciencia de datos reutilizable; no obstante, cada proyecto es un directorio de código o un repositorio Git que utiliza un archivo descriptor para indicar las dependencias y cómo ejecutar el código.

* **Modelos:** Los modelos MLflow son un estándar para la distribución de modelos de aprendizaje automático en una variedad de sabores. Hay varias herramientas disponibles para ayudar con el despliegue de varios modelos. Cada modelo se guarda como un directorio con archivos arbitrarios y un archivo de descripción del modelo ML que identifica los sabores en los que se puede utilizar.

* **Registro:** Le ofrece un almacén de modelos centralizado, una interfaz de usuario y un conjunto de API para gestionar de forma colaborativa el ciclo de vida completo de su modelo MLflow. Proporciona linaje de modelos, versiones de modelos, transiciones de etapas y anotaciones.

**Airflow** es una plataforma de gestión de flujos de trabajo de código abierto creada por Airbnb en 2014 para crear, supervisar y programar mediante programación los crecientes flujos de trabajo de la empresa. Algunos de los componentes de Airflow son los siguientes:

* **Scheduler:** Supervisa las tareas y los DAG, activa los flujos de trabajo programados y envía las tareas al ejecutor para que las ejecute. Está diseñado para ejecutarse como un servicio persistente en el entorno de producción de Airflow.

* **Ejecutores:** Son mecanismos que ejecutan instancias de tareas; prácticamente ejecutan todo en el planificador. Los ejecutores tienen una API común y puede intercambiarlos en función de los requisitos de su instalación. Sólo puede tener configurado un ejecutor por vez.

* **Servidor web:** Una interfaz de usuario que muestra el estado de sus trabajos y le permite ver, activar y depurar DAGs (**) y tareas. También le ayuda a interactuar con la base de datos y a leer registros del almacén de archivos remoto.

* **Base de datos de metadatos:** La base de datos de metadatos es utilizada por el ejecutor, el servidor web y el scheduler para almacenar el estado.

**Data Version Control(DVC)** es un sistema de control de versiones de código abierto utilizado en proyectos de aprendizaje automático. También se conoce como Git para ML. Se ocupa de las versiones de datos en lugar de las versiones de código. DVC le ayuda a lidiar con grandes modelos y archivos de datos que no pueden ser manejados usando Git. Le permite almacenar información sobre las diferentes versiones de sus datos para realizar un seguimiento adecuado de los datos de ML y acceder al rendimiento de su modelo más tarde. Puede definir un repositorio remoto para enviar sus datos y modelos, lo que facilita la colaboración entre los miembros del equipo.

Para obtener el resultado deseado, los usuarios no tienen que recordar manualmente qué modelo de datos utiliza qué conjunto de datos y qué acciones se llevaron a cabo; de todo esto se encarga DVC. Consiste en un conjunto de herramientas y procesos que rastrean las versiones cambiantes de los datos y las colecciones de datos anteriores. Los repositorios de DVC contienen los archivos que están bajo el efecto del sistema de control de versiones. Se mantiene un estado clasificado para cada cambio que se confirma en cualquier archivo de datos.

[![Airflow vs. Kubeflow vs. MLFlow](./source/airflow-mlflow-kubeflow.webp)](https://aicurious.io/blog/2022-03-26-airflow-mlflow-or-kubeflow-for-mlops)

Luego de analizar las capacidades de cada uno de los sistemas vistos anteriormente, podemos decir que si nuestro sistema necesita tratar con múltiples tipos de flujo de trabajo, no sólo aprendizaje automático, Airflow puede ayudarnos mejor. Es un marco de orquestación de flujos de trabajo maduro, con soporte para muchos operadores, además del aprendizaje automático.

Si deseamos un sistema con patrones prediseñados para el aprendizaje automático y que funcione a gran escala en clústeres Kubenetes, podemos considerar Kubeflow. Muchos componentes específicos de ML en Kubeflow pueden ahorrarnos tiempo a comparación de si los hacemos con Airflow.

Si queremos desplegar MLOps en un sistema a pequeña escala (por ejemplo, una estación de trabajo, o un portátil), nos conviene elegir Airflow + MLflow, ya que elimina la necesidad de configurar y ejecutar un sistema Kubenetes, y ahorrar más recursos para las tareas principales.

Como DVC se dedica a una porción muy específica y similar a MLFlow, queda en la misma categoría que el párrafo anterior, no cumpliendo el ciclo completo y necesitando de la combinación con otro sistema.

En nuestro caso de aplicación, como nuestro cluster ya tiene Kubernetes y consideramos que es más completo y abarca todo el ciclo de trabajo completo, **la elección ideal sería Kubeflow**, por lo que ahondaremos más en el mismo para poder realizar su implementación.

>(*) *Job operator:* Es un recurso personalizado de Kubernetes que permite correr tareas de entrenamiento de TensorFlow en dicha plataforma.
>
>(**) *DAGs:* Directed Acyclic Graph, es una forma de modelar las redes neuronales en forma de nodos interconectados por flechas.

## Descripción del entorno de trabajo

### Recursos físicos

Conjunto de 3 PC's con los siguientes recursos cada una:

* CPU's: Ryzen 9 XXXX
* Memoria RAM: 32GB
* Almacenamiento: X GB
* GPU's: NO, por el momento.

### Virtualización - Proxmox

Proxmox Virtual Environment, comúnmente conocido como Proxmox, es una plataforma de virtualización de código abierto que permite la administración y la implementación de máquinas virtuales (VM) y contenedores en un entorno integrado. Proxmox se utiliza para crear y gestionar entornos virtuales en servidores físicos y es especialmente útil en entornos de centro de datos y en la administración de servidores.

Los siguientes son los conceptos clave y el principio de funcionamiento de Proxmox:

1. **Virtualización basada en KVM y contenedores:** Proxmox utiliza dos tecnologías de virtualización principales: KVM (Kernel-based Virtual Machine) para máquinas virtuales y contenedores LXC (Linux Containers). Esto proporciona flexibilidad para ejecutar tanto VMs completas como contenedores ligeros en la misma plataforma.
2. **Interfaz web de gestión:** Proxmox ofrece una interfaz web de administración fácil de usar llamada Proxmox Virtual Environment (PVE). A través de esta interfaz, los administradores pueden gestionar recursos físicos, crear VMs y contenedores, realizar copias de seguridad, monitorear el rendimiento y llevar a cabo muchas otras tareas relacionadas con la virtualización.
3. **Gestión centralizada de recursos:** Proxmox permite aprovechar al máximo los recursos físicos del servidor al proporcionar una gestión centralizada de CPU, memoria, almacenamiento y redes. Los recursos se pueden asignar de manera dinámica y compartida entre VMs y contenedores según sea necesario.
4. **Almacenamiento:** Proxmox admite una variedad de opciones de almacenamiento, incluidos discos locales, almacenamiento compartido en red (NFS, Ceph, etc.) y almacenamiento en la nube. Esto permite a los administradores configurar soluciones de almacenamiento adecuadas para sus necesidades.
5. **Administración de copias de seguridad:** Proxmox incluye herramientas integradas para realizar copias de seguridad y restaurar máquinas virtuales y contenedores. Los administradores pueden programar copias de seguridad automáticas y almacenar copias de seguridad en ubicaciones seguras.
6. **Administración de clústeres:** Proxmox permite la creación de clústeres de servidores para mejorar la alta disponibilidad y la redundancia. Esto significa que las VMs y los contenedores pueden migrar de un nodo a otro en caso de fallos, lo que garantiza la continuidad del servicio.
7. **Seguridad y aislamiento:** Proxmox se esfuerza por garantizar el aislamiento y la seguridad entre VMs y contenedores. Las tecnologías de virtualización y contenedores se utilizan para asegurarse de que los sistemas en ejecución no interfieran entre sí.
8. **Escalabilidad:** Los administradores pueden agregar servidores adicionales al clúster Proxmox según sea necesario para aumentar la capacidad de procesamiento y almacenamiento de la plataforma.

### Aprovisionamiento

En el contexto de sistemas de software y tecnología de la información, el término "aprovisionamiento" se refiere al proceso de configurar y suministrar recursos informáticos, como servidores, redes, almacenamiento y otros componentes de infraestructura, para satisfacer las necesidades de una aplicación o servicio específico. El aprovisionamiento implica la asignación de recursos de manera eficiente y escalable, de modo que los sistemas puedan funcionar de manera óptima y satisfacer la demanda de los usuarios.

El aprovisionamiento puede ser un proceso manual o automatizado, dependiendo de la complejidad de la infraestructura y de las herramientas disponibles. En entornos de nube, como Amazon Web Services (AWS), Microsoft Azure o Google Cloud Platform, el aprovisionamiento se realiza frecuentemente mediante servicios de aprovisionamiento automático que permiten escalar los recursos de manera dinámica según las necesidades de la aplicación. Esto es especialmente útil para garantizar que los sistemas sean flexibles y capaces de manejar cargas de trabajo variables.

#### De Infraestructura - Terraform

Terraform es una herramienta de código abierto desarrollada por HashiCorp que se utiliza para el aprovisionamiento y la gestión de **infraestructura como código (IaC, por sus siglas en inglés).** IaC es una práctica en la que la infraestructura se define y administra mediante código, lo que permite automatizar y estandarizar la creación y configuración de recursos de infraestructura, como servidores, redes, bases de datos y otros componentes, de manera consistente y repetible.

El principio de funcionamiento de Terraform se basa en los siguientes conceptos clave:

1. **Declaración de infraestructura como código (IaC):** En Terraform, los usuarios definen la infraestructura deseada en archivos de configuración escritos en un lenguaje específico llamado HashiCorp Configuration Language (HCL) o en formato JSON. En estos archivos, se describen los recursos necesarios, sus propiedades y sus dependencias.
2. **Configuración declarativa:** Terraform adopta un enfoque declarativo, lo que significa que los usuarios especifican lo que quieren lograr, pero no necesariamente cómo hacerlo paso a paso. Terraform se encarga de determinar la secuencia de acciones necesarias para llevar la infraestructura actual al estado deseado.
3. **Planificación y ejecución:** Después de definir la configuración, los usuarios ejecutan comandos de Terraform, como `terraform init`, `terraform plan` y `terraform apply`. El comando `plan` es especialmente útil, ya que muestra una vista previa de los cambios que Terraform realizará en la infraestructura actual para llevarla al estado deseado, sin aplicarlos de inmediato.
4. **Grafo de recursos:** Terraform crea un grafo de recursos que representa las dependencias entre los recursos definidos en la configuración. Esto permite que Terraform determine el orden en el que se deben crear o modificar los recursos para garantizar la coherencia de la infraestructura.
5. **Estado de infraestructura:** Terraform mantiene un archivo de estado que registra el estado actual de la infraestructura gestionada. Este archivo se utiliza para realizar un seguimiento de los recursos creados y para determinar los cambios necesarios durante las ejecuciones posteriores de Terraform.
6. **Aplicación y gestión de cambios:** Una vez que los usuarios están satisfechos con la vista previa del plan de ejecución, pueden aplicar los cambios utilizando el comando `apply`. Terraform se encarga de llevar la infraestructura al estado deseado, creando, actualizando o eliminando recursos según sea necesario.

Terraform es altamente extensible y es compatible con una amplia variedad de proveedores de infraestructura, incluidos proveedores de nube como AWS, Azure, Google Cloud, así como recursos locales, como servidores físicos y máquinas virtuales en centros de datos locales. Esto lo convierte en una herramienta poderosa para la gestión de infraestructura en entornos de nube, entornos locales o híbridos.

#### De Software - Ansible

Ansible es una herramienta de automatización y gestión de configuración de código abierto que se utiliza para aprovisionar y administrar software en sistemas y servidores. A diferencia de Terraform, que se enfoca en la infraestructura subyacente, Ansible se centra en la configuración y el mantenimiento de aplicaciones y servicios en sistemas ya aprovisionados. Ansible permite automatizar tareas como la instalación de software, la configuración de servidores, la actualización de aplicaciones y la gestión de configuraciones de manera eficiente y consistente.

El principio de funcionamiento de Ansible se basa en los siguientes conceptos clave:

1. **Agentless:** Ansible es una herramienta "sin agente", lo que significa que no es necesario instalar software adicional en los sistemas de destino para que Ansible funcione. En lugar de utilizar agentes permanentes, Ansible se comunica con los sistemas de destino a través de SSH (para sistemas Unix/Linux) o WinRM (para sistemas Windows). Esto facilita la implementación y la gestión de Ansible en una amplia variedad de entornos.
2. **Playbooks y Roles:** Ansible utiliza Playbooks, que son archivos de texto YAML que describen las tareas que se deben realizar en los sistemas de destino. Los Playbooks son altamente legibles y permiten a los usuarios definir tareas específicas, como instalar software, configurar archivos de configuración y realizar otras acciones. Para promover la reutilización y la organización, las tareas se pueden agrupar en Roles, que son conjuntos de tareas relacionadas que se pueden aplicar a diferentes hosts.
3. **Declarativo:** Ansible sigue un enfoque declarativo, lo que significa que los Playbooks describen el estado deseado del sistema en lugar de los pasos específicos para llegar a ese estado. Ansible se encarga de determinar cómo llevar los sistemas al estado deseado.
4. **Módulos:** Ansible incluye una amplia colección de módulos que permiten realizar una variedad de tareas en los sistemas de destino. Estos módulos son responsables de ejecutar acciones específicas, como instalar paquetes, copiar archivos, reiniciar servicios y más. Los usuarios pueden utilizar estos módulos en sus Playbooks para lograr sus objetivos de configuración.
5. **Inventario:** Ansible utiliza un archivo de inventario para definir los hosts (sistemas de destino) en los que se ejecutarán las tareas. Los inventarios pueden ser estáticos o dinámicos, lo que permite gestionar grupos de hosts de manera flexible y escalable.
6. **Ejecución:** Para ejecutar un Playbook o una tarea de Ansible, los usuarios pueden utilizar el comando `ansible-playbook` o comandos similares. Ansible se encarga de conectarse a los sistemas de destino, aplicar las tareas definidas en el Playbook y garantizar que el sistema esté en el estado deseado.

#### Uso en conjunto - Terraform + Ansible

Terraform y Ansible son dos herramientas complementarias que se utilizan comúnmente juntas para gestionar de manera integral tanto la infraestructura como la configuración de software en un entorno de TI. La combinación de ambas herramientas permite automatizar todo el ciclo de vida de un sistema, desde la creación y aprovisionamiento de la infraestructura hasta la configuración y administración de aplicaciones y servicios en dicha infraestructura. Aquí hay algunas formas típicas en las que se utilizan Terraform y Ansible juntos:

1. **Provisionamiento de infraestructura con Terraform:** Terraform se utiliza para crear y aprovisionar la infraestructura subyacente, como servidores, redes, bases de datos y otros recursos en la nube o en centros de datos locales. Terraform puede configurar la topología de la infraestructura y asegurarse de que los recursos estén disponibles y funcionando según lo previsto.
2. **Configuración de servidores y aplicaciones con Ansible:** Una vez que Terraform ha creado la infraestructura, Ansible se encarga de configurar y gestionar los servidores y aplicaciones en esa infraestructura. Ansible automatiza tareas como la instalación de software, la configuración de archivos de configuración, la aplicación de parches y la gestión de servicios en los servidores.
3. **Orquestación completa de aplicaciones:** Terraform y Ansible se pueden utilizar en conjunto para orquestar la implementación de aplicaciones completas. Terraform puede aprovisionar servidores y recursos, y luego Ansible puede configurar y administrar la aplicación en esos servidores, garantizando que todo el entorno esté funcionando correctamente.
4. **Actualizaciones y cambios en la infraestructura:** Cuando es necesario realizar cambios en la infraestructura, como agregar o quitar servidores, Terraform se encarga de modificar la infraestructura de manera controlada y segura. Luego, Ansible puede aplicar las configuraciones necesarias en los nuevos recursos o realizar ajustes en los recursos existentes para acomodar los cambios.
5. **Automatización de despliegues y escalabilidad:** Terraform y Ansible permiten escalar la infraestructura y las aplicaciones de manera automatizada en función de la demanda. Por ejemplo, cuando se necesita escalar una aplicación web, Terraform puede agregar nuevos servidores, y Ansible puede configurarlos automáticamente para unirse al clúster de aplicaciones existente.
6. **Gestión de la configuración continua:** Ansible se utiliza para garantizar que la configuración de software se mantenga coherente a lo largo del tiempo. Puede aplicar políticas de configuración y asegurarse de que los servidores y las aplicaciones cumplan con los estándares de seguridad y rendimiento.

#### ¿Cómo se comunican Terraform y Ansible para poder realizar las configuraciones?

Tanto Terraform como Ansible son herramientas de automatización que pueden comunicarse con otros sistemas y recursos utilizando diferentes protocolos y mecanismos de autenticación. A continuación, se describen los protocolos y métodos de autenticación comunes utilizados por cada una de estas herramientas:

**Terraform:**

1. **APIs de proveedores de nube:** Terraform se comunica con los proveedores de nube (como AWS, Azure, Google Cloud, etc.) a través de sus respectivas APIs. Estas APIs suelen utilizar protocolos basados en HTTP/HTTPS, como REST o gRPC, para la comunicación. Terraform utiliza las credenciales del proveedor de nube (por ejemplo, las claves de acceso de AWS) para autenticarse y realizar operaciones en la nube.

2. **SSH:** En ocasiones, Terraform puede utilizar SSH para comunicarse con máquinas virtuales o servidores provisionados a través de SSH. En este caso, se utilizan pares de claves SSH (pública y privada) para la autenticación. La clave pública se coloca en el servidor de destino, y la clave privada se utiliza para autenticar la conexión desde Terraform.

**Ansible:**

1. **SSH:** Ansible utiliza SSH como el protocolo predeterminado para conectarse a los servidores de destino y ejecutar comandos o tareas en ellos. Al igual que con Terraform, Ansible utiliza pares de claves SSH (pública y privada) para la autenticación. La clave pública se debe agregar a los servidores de destino y la clave privada se utiliza para autenticar las conexiones desde la máquina que ejecuta Ansible.

2. **WinRM:** Para sistemas Windows, Ansible puede utilizar WinRM (Windows Remote Management) como protocolo de comunicación en lugar de SSH. WinRM permite la administración remota de servidores Windows y utiliza autenticación basada en credenciales (nombre de usuario y contraseña) o certificados.

En cuanto a la comunicación con Proxmox, tanto Terraform como Ansible pueden utilizar SSH para conectarse a los nodos de Proxmox y administrarlos, ya que Proxmox es compatible con SSH para la administración remota. En este caso, se requerirán las claves SSH adecuadas y las configuraciones de acceso para autenticarse en los nodos de Proxmox.

### Orquestación de contenedores - Kubernetes

Kubernetes, a menudo abreviado como K8s, es una plataforma de código abierto diseñada para la automatización, la implementación, la escalabilidad y la administración de aplicaciones en contenedores. Kubernetes es ampliamente utilizado en el despliegue y la gestión de aplicaciones en entornos de nube y en centros de datos locales. Su principal objetivo es facilitar la orquestación de contenedores, lo que permite administrar aplicaciones de manera eficiente y escalable.

Los siguientes son los conceptos clave y el principio de funcionamiento de Kubernetes:

1. **Contenedores:** Kubernetes se basa en la tecnología de contenedores, que permite empaquetar aplicaciones y sus dependencias en entornos aislados y portátiles. Los contenedores son ligeros, rápidos de implementar y pueden ejecutarse de manera consistente en cualquier entorno compatible con contenedores.
2. **Orquestación:** Kubernetes se utiliza para orquestar la implementación y la administración de contenedores en clústeres de servidores. Esto significa que Kubernetes automatiza tareas como la distribución de contenedores en servidores, la recuperación ante fallos, la escalabilidad de aplicaciones y la gestión de recursos.
3. **Clúster de Kubernetes:** Un clúster de Kubernetes es un conjunto de nodos (servidores) que ejecutan el software de Kubernetes y que trabajan juntos para administrar aplicaciones en contenedores. Los clústeres pueden incluir nodos maestros (control plane) y nodos de trabajo (worker nodes).
4. **Nodos maestros:** Los nodos maestros son responsables de la gestión y el control del clúster de Kubernetes. Se encargan de tomar decisiones sobre la programación de contenedores, la asignación de recursos, la gestión de la alta disponibilidad y la administración de la configuración del clúster.
5. **Nodos de trabajo:** Los nodos de trabajo son los servidores donde se ejecutan los contenedores. Cada nodo de trabajo tiene un agente de Kubernetes llamado kubelet que se comunica con el nodo maestro y administra la ejecución de los contenedores en el nodo.
6. **Despliegues y Pods:** Kubernetes utiliza abstracciones como Despliegues (Deployments) y Pods para definir y gestionar aplicaciones. Los Despliegues especifican cómo se deben ejecutar los Pods (que son la unidad más pequeña en Kubernetes) y controlan la escalabilidad, la actualización y el equilibrio de carga de las aplicaciones.
7. **Servicios:** Kubernetes ofrece Servicios para exponer aplicaciones y servicios a través de una red. Los Servicios permiten la comunicación entre Pods y garantizan la disponibilidad incluso cuando los Pods se escalan o cambian de ubicación.
8. **Escalabilidad y autorrecuperación:** Kubernetes permite escalar aplicaciones automáticamente según la demanda y recuperarse de fallos de forma automática. Esto garantiza que las aplicaciones sean altamente disponibles y capaces de manejar cargas de trabajo variables.
9. **Configuración declarativa:** En Kubernetes, los usuarios definen el estado deseado de las aplicaciones y de la infraestructura a través de archivos de configuración YAML o JSON. Kubernetes se encarga de llevar el sistema al estado deseado y mantenerlo de esa manera.

### Despliegue, administración y la orquestación de flujos de trabajo de ML - Kubeflow

Kubeflow es una plataforma de código abierto diseñada específicamente para el despliegue, la administración y la orquestación de flujos de trabajo de aprendizaje automático (machine learning, ML) en Kubernetes. Esta plataforma se creó para facilitar el desarrollo, la capacitación y la implementación de modelos de aprendizaje automático de manera eficiente y escalable en entornos basados en contenedores, aprovechando las ventajas de Kubernetes para la orquestación y la gestión de recursos.

Los siguientes son los conceptos clave y el principio de funcionamiento de Kubeflow:

1. **Gestión de flujos de trabajo de ML:** Kubeflow se centra en la gestión y la automatización de flujos de trabajo de ML, que involucran múltiples etapas, desde la recopilación de datos y la preparación de datos hasta el entrenamiento de modelos y la implementación de modelos en producción.

2. **Soporte para contenedores:** Kubeflow se integra perfectamente con la naturaleza basada en contenedores de Kubernetes. Los flujos de trabajo de ML se empaquetan en contenedores, lo que facilita la portabilidad y la implementación en cualquier clúster de Kubernetes.

3. **Componentes modulares:** Kubeflow se compone de varios componentes y herramientas que se pueden utilizar de manera modular según las necesidades específicas de un proyecto de aprendizaje automático. Algunos de los componentes clave incluyen Katib (para la optimización de hiperparámetros), KFServing (para la implementación de modelos), Pipelines (para la creación y la gestión de flujos de trabajo) y más.

4. **Orquestación de flujos de trabajo:** Kubeflow Pipelines es una de las características principales que permite a los usuarios definir y ejecutar flujos de trabajo de ML como secuencias de pasos interconectados. Cada paso puede ser una tarea de preparación de datos, entrenamiento de modelos, evaluación de modelos o implementación en producción. Los flujos de trabajo son configurables y reproducibles.

5. **Automatización y escalabilidad:** Kubeflow simplifica la automatización de flujos de trabajo, lo que significa que los flujos de trabajo se pueden ejecutar de manera programática en respuesta a eventos o programarse para ejecutarse de manera regular. Además, Kubernetes facilita la escalabilidad de recursos para manejar grandes volúmenes de datos y entrenamientos de modelos intensivos en recursos.

6. **Gestión de modelos:** Kubeflow ofrece herramientas para el registro, la versión y la administración de modelos de aprendizaje automático. Esto facilita la colaboración y la gestión de modelos a lo largo de su ciclo de vida.

7. **Monitorización y seguimiento:** Kubeflow incluye capacidades de monitoreo y seguimiento que permiten a los usuarios evaluar el rendimiento de los modelos implementados en producción y realizar ajustes según sea necesario.

En resumen, Kubeflow es una plataforma de código abierto que simplifica y optimiza la gestión de flujos de trabajo de aprendizaje automático en entornos de Kubernetes. Facilita la implementación, la escalabilidad, la automatización y la gestión de modelos de ML en entornos basados en contenedores, lo que mejora la eficiencia y la reproducibilidad en proyectos de aprendizaje automático.
