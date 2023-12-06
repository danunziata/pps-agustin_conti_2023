---
title: Desarrollo
---

## Objetivos

### Objetivo General

Explorar, evaluar un conjunto de tecnologías esenciales que permiten la implementación exitosa de prácticas de Machine Learning Operations (MLOps) en el entorno universitario, haciendo hincapié en la reutilización, la reproducibilidad y la escalabilidad. La implementación de sistemas de MLOps se ha vuelto cada vez más crucial, ya que proporciona la infraestructura necesaria para respaldar a los científicos y expertos en la universidad en su búsqueda de soluciones basadas en Machine Learning. Facilita la gestión eficiente del ciclo de vida de los modelos, desde su desarrollo y entrenamiento hasta su despliegue y monitoreo, permitiendo así la reutilización de los recursos, la reproducibilidad de los resultados y la escalabilidad de las soluciones.

### Objetivos Específicos

- Investigar y evaluar tecnologías clave en el campo de MLOps, centrándose en la reutilización, reproducibilidad y escalabilidad.

- Seleccionar la herramienta más adecuada, entre las tecnologías disponibles open source, para implementar prácticas eficientes de MLOps en el entorno universitario.

- Diseñar e implementar la infraestructura basada en la herramienta seleccionada, que permita gestionar el ciclo de vida completo de los modelos de Machine Learning.

- Desarrollar pipelines de flujo de trabajo utilizando la herramienta seleccionada, para automatizar tareas como el entrenamiento, evaluación y despliegue de modelos.

- Integrar modelos de Machine Learning en los pipelines, asegurando la correcta reproducción de los resultados y la reutilización de componentes.

- Realizar pruebas exhaustivas y ajustes en los pipelines implementados, garantizando su funcionamiento correcto y eficiente.

- Redactar un informe final que documente el proceso de implementación, destacando la reutilización, reproducibilidad y escalabilidad logradas, así como los beneficios obtenidos para la universidad en el ámbito de MLOps.

## Descripción de la Empresa

El Grupo de Investigación en Ciencia de Datos (GCID) se sitúa en la vanguardia de la investigación y la innovación en el campo de la Ciencia de Datos. Este grupo se caracteriza por su enfoque interdisciplinario, que abarca métodos científicos, procesos y sistemas diseñados para extraer conocimiento de datos en diversas formas, desde datos estructurados hasta datos no estructurados. La Ciencia de Datos es una disciplina que unifica estadísticas, análisis de datos, aprendizaje automático y métodos relacionados para comprender y analizar fenómenos reales utilizando técnicas y teorías provenientes de diversas áreas del conocimiento.
El GCID se encuentra en el epicentro de la revolución tecnológica de la Industria 4.0, donde la acumulación exponencial de datos, la inteligencia artificial y la interconexión masiva de sistemas y dispositivos digitales están transformando radicalmente la forma en que las organizaciones operan y toman decisiones. El grupo se enfoca en aprovechar estas tendencias para brindar soluciones tanto a la Universidad Nacional de Río Cuarto como a entidades públicas y privadas a nivel nacional e internacional.
Para abordar los desafíos de la Ciencia de Datos, el GCID trabaja en estrecha colaboración con tecnologías habilitadoras como el Internet de las cosas (IoT), La Industria 4.0, los sistemas ciber físicos, la cultura maker entre otros. Estas tecnologías proporcionan el marco necesario para la recopilación, el procesamiento y el análisis de datos en tiempo real.
El grupo reconoce que extraer información valiosa de grandes volúmenes de datos es un desafío multidisciplinario que requiere una visión integral. Por lo tanto, los miembros del grupo provienen de diversos campos, incluyendo matemáticas, estadísticas, ciencia de la información y computación, lo que promueve la colaboración y el enfoque conjunto en la resolución de problemas. El GCID se esfuerza por convertirse en un referente en la Universidad Nacional de Río Cuarto y la región en temas relacionados con la Ciencia de Datos, a través de la docencia, la investigación, el desarrollo tecnológico y la transferencia de conocimiento al medio.

## Descripción de las tareas realizadas

### Comparación de herramientas

**Kubeflow** ofrece una forma escalable de entrenar y desplegar modelos en Kubernetes. Es un medio de orquestación que permite que un framework de aplicaciones en la nube funcione sin problemas. Algunos de los componentes de Kubeflow son los siguientes:

- **Notebooks:** Ofrece servicios para crear y gestionar cuadernos Jupyter interactivos en entornos corporativos. También incluye la posibilidad de que los usuarios construyan contenedores de Notebooks o pods directamente en clusters.

- **Entrenamiento de modelos de TensorFlow:** Kubeflow viene con un "job operator" de TensorFlow personalizado que facilita la configuración y ejecución del entrenamiento de modelos en Kubernetes. Kubeflow también admite otros frameworks mediante job operators a medida, pero su madurez puede variar.

- **Pipelines:** Los pipelines de Kubeflow permiten construir y gestionar flujos de trabajo de aprendizaje automático de múltiples pasos que se ejecutan en contenedores Docker.

- **Despliegue:** Kubeflow ofrece varias formas de desplegar modelos en Kubernetes a través de complementos externos.

**MLflow** es un framework de código abierto para el seguimiento de todo el ciclo de aprendizaje automático de principio a fin, desde la formación hasta la implementación. Entre las funciones que ofrece se encuentran el seguimiento de modelos, la gestión, el empaquetado y las transiciones centralizadas de etapas del ciclo de vida. Algunos de los componentes de MLflow son los siguientes:

- **Seguimiento:** Mientras ejecutas tu código de aprendizaje automático, hay una API y una interfaz de usuario para registrar parámetros, versiones de código, métricas y archivos de salida para que puedas visualizarlos más tarde.

- **Proyecto:** Proporcionan un estilo estándar para empaquetar código de ciencia de datos reutilizable; no obstante, cada proyecto es un directorio de código o un repositorio Git que utiliza un archivo descriptor para indicar las dependencias y cómo ejecutar el código.

- **Modelos:** Los modelos MLflow son un estándar para la distribución de modelos de aprendizaje automático en una variedad de sabores. Hay varias herramientas disponibles para ayudar con el despliegue de varios modelos. Cada modelo se guarda como un directorio con archivos arbitrarios y un archivo de descripción del modelo ML que identifica los sabores en los que se puede utilizar.

- **Registro:** Le ofrece un almacén de modelos centralizado, una interfaz de usuario y un conjunto de API para gestionar de forma colaborativa el ciclo de vida completo de su modelo MLflow. Proporciona linaje de modelos, versiones de modelos, transiciones de etapas y anotaciones.

**Airflow** es una plataforma de gestión de flujos de trabajo de código abierto creada por Airbnb en 2014 para crear, supervisar y programar mediante programación los crecientes flujos de trabajo de la empresa. Algunos de los componentes de Airflow son los siguientes:

- **Scheduler:** Supervisa las tareas y los DAG, activa los flujos de trabajo programados y envía las tareas al ejecutor para que las ejecute. Está diseñado para ejecutarse como un servicio persistente en el entorno de producción de Airflow.

- **Ejecutores:** Son mecanismos que ejecutan instancias de tareas; prácticamente ejecutan todo en el planificador. Los ejecutores tienen una API común y puede intercambiarlos en función de los requisitos de su instalación. Sólo puede tener configurado un ejecutor por vez.

- **Servidor web:** Una interfaz de usuario que muestra el estado de sus trabajos y le permite ver, activar y depurar DAGs (**) y tareas. También le ayuda a interactuar con la base de datos y a leer registros del almacén de archivos remoto.

- **Base de datos de metadatos:** La base de datos de metadatos es utilizada por el ejecutor, el servidor web y el scheduler para almacenar el estado.

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

### Diseño e implementación de la infraestructura basada en la herramienta seleccionada

Para la plataforma que deseamos implementar (Kubeflow) necesitamos cumplir con varios requisitos de infraestructura y de software instalado sobre la misma. En nuestro caso contamos con un Cluster conformado por 3 PC's sobre las cuales utilzaremos la virtualización para generar máquinas virtuales con ciertos recursos asignados y sobre dichas máquinas virtuales se aprovisionará el software necesario.

#### Recursos físicos - Cluster del Laboratorio

Conjunto de 3 PC's con los siguientes recursos cada una:

- CPU's: 96 CORES
- Memoria RAM: 128 GB
- Almacenamiento: 2 TB
- GPU's: NO, por el momento.

Estos recursos serán agrupados con una plataforma de virtualización.

#### Virtualización - Proxmox

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

En nuestro caso es la plataforma de virtualización utilizada debido a las múltiples prestaciones nombradas.

#### Aprovisionamiento de infraestructura y software

En el contexto de sistemas de software y tecnología de la información, el término "aprovisionamiento" se refiere al proceso de configurar y suministrar recursos informáticos, como servidores, redes, almacenamiento y otros componentes de infraestructura, para satisfacer las necesidades de una aplicación o servicio específico. El aprovisionamiento implica la asignación de recursos de manera eficiente y escalable, de modo que los sistemas puedan funcionar de manera óptima y satisfacer la demanda de los usuarios.

El aprovisionamiento puede ser un proceso manual o automatizado, dependiendo de la complejidad de la infraestructura y de las herramientas disponibles. En entornos de nube, como Amazon Web Services (AWS), Microsoft Azure o Google Cloud Platform, el aprovisionamiento se realiza frecuentemente mediante servicios de aprovisionamiento automático que permiten escalar los recursos de manera dinámica según las necesidades de la aplicación. Esto es especialmente útil para garantizar que los sistemas sean flexibles y capaces de manejar cargas de trabajo variables.

Este concepto nos es útil también para nuestra aplicación local, podremos desplegar máquinas virtuales en Proxmox y configurarlas.

##### De Infraestructura - Terraform

Terraform es una herramienta de código abierto desarrollada por HashiCorp que se utiliza para el aprovisionamiento y la gestión de **infraestructura como código (IaC, por sus siglas en inglés).** IaC es una práctica en la que la infraestructura se define y administra mediante código, lo que permite automatizar y estandarizar la creación y configuración de recursos de infraestructura, como servidores, redes, bases de datos y otros componentes, de manera consistente y repetible.

El principio de funcionamiento de Terraform se basa en los siguientes conceptos clave:

1. **Declaración de infraestructura como código (IaC):** En Terraform, los usuarios definen la infraestructura deseada en archivos de configuración escritos en un lenguaje específico llamado HashiCorp Configuration Language (HCL) o en formato JSON. En estos archivos, se describen los recursos necesarios, sus propiedades y sus dependencias.
2. **Configuración declarativa:** Terraform adopta un enfoque declarativo, lo que significa que los usuarios especifican lo que quieren lograr, pero no necesariamente cómo hacerlo paso a paso. Terraform se encarga de determinar la secuencia de acciones necesarias para llevar la infraestructura actual al estado deseado.
3. **Planificación y ejecución:** Después de definir la configuración, los usuarios ejecutan comandos de Terraform, como `terraform init`, `terraform plan` y `terraform apply`. El comando `plan` es especialmente útil, ya que muestra una vista previa de los cambios que Terraform realizará en la infraestructura actual para llevarla al estado deseado, sin aplicarlos de inmediato.
4. **Grafo de recursos:** Terraform crea un grafo de recursos que representa las dependencias entre los recursos definidos en la configuración. Esto permite que Terraform determine el orden en el que se deben crear o modificar los recursos para garantizar la coherencia de la infraestructura.
5. **Estado de infraestructura:** Terraform mantiene un archivo de estado que registra el estado actual de la infraestructura gestionada. Este archivo se utiliza para realizar un seguimiento de los recursos creados y para determinar los cambios necesarios durante las ejecuciones posteriores de Terraform.
6. **Aplicación y gestión de cambios:** Una vez que los usuarios están satisfechos con la vista previa del plan de ejecución, pueden aplicar los cambios utilizando el comando `apply`. Terraform se encarga de llevar la infraestructura al estado deseado, creando, actualizando o eliminando recursos según sea necesario.

Terraform es altamente extensible y es compatible con una amplia variedad de proveedores de infraestructura, incluidos proveedores de nube como AWS, Azure, Google Cloud, así como recursos locales, como servidores físicos y máquinas virtuales en centros de datos locales. Esto lo convierte en una herramienta poderosa para la gestión de infraestructura en entornos de nube, entornos locales o híbridos.

Para nuestro caso, necesitamos proveer máquinas virtuales sobre Proxmox, gracias a Terraform pudimos hacer una configuración previa considerando las necesidades de recursos, pudiendo definir la cantidad de núcleos, memoria RAM y almacenamiento, además de configurar algunas funcionalidades escenciales para la identificación (como el nombre de las máquinas e ID), la administración (claves SSH) y la conectividad (IPs), permitiendo así, tener una base para luego será usada para el aprovisionamiento de software.

##### De Software - Ansible

Ansible es una herramienta de automatización y gestión de configuración de código abierto que se utiliza para aprovisionar y administrar software en sistemas y servidores. A diferencia de Terraform, que se enfoca en la infraestructura subyacente, Ansible se centra en la configuración y el mantenimiento de aplicaciones y servicios en sistemas ya aprovisionados. Ansible permite automatizar tareas como la instalación de software, la configuración de servidores, la actualización de aplicaciones y la gestión de configuraciones de manera eficiente y consistente.

El principio de funcionamiento de Ansible se basa en los siguientes conceptos clave:

1. **Agentless:** Ansible es una herramienta "sin agente", lo que significa que no es necesario instalar software adicional en los sistemas de destino para que Ansible funcione. En lugar de utilizar agentes permanentes, Ansible se comunica con los sistemas de destino a través de SSH (para sistemas Unix/Linux) o WinRM (para sistemas Windows). Esto facilita la implementación y la gestión de Ansible en una amplia variedad de entornos.
2. **Playbooks y Roles:** Ansible utiliza Playbooks, que son archivos de texto YAML que describen las tareas que se deben realizar en los sistemas de destino. Los Playbooks son altamente legibles y permiten a los usuarios definir tareas específicas, como instalar software, configurar archivos de configuración y realizar otras acciones. Para promover la reutilización y la organización, las tareas se pueden agrupar en Roles, que son conjuntos de tareas relacionadas que se pueden aplicar a diferentes hosts.
3. **Declarativo:** Ansible sigue un enfoque declarativo, lo que significa que los Playbooks describen el estado deseado del sistema en lugar de los pasos específicos para llegar a ese estado. Ansible se encarga de determinar cómo llevar los sistemas al estado deseado.
4. **Módulos:** Ansible incluye una amplia colección de módulos que permiten realizar una variedad de tareas en los sistemas de destino. Estos módulos son responsables de ejecutar acciones específicas, como instalar paquetes, copiar archivos, reiniciar servicios y más. Los usuarios pueden utilizar estos módulos en sus Playbooks para lograr sus objetivos de configuración.
5. **Inventario:** Ansible utiliza un archivo de inventario para definir los hosts (sistemas de destino) en los que se ejecutarán las tareas. Los inventarios pueden ser estáticos o dinámicos, lo que permite gestionar grupos de hosts de manera flexible y escalable.
6. **Ejecución:** Para ejecutar un Playbook o una tarea de Ansible, los usuarios pueden utilizar el comando `ansible-playbook` o comandos similares. Ansible se encarga de conectarse a los sistemas de destino, aplicar las tareas definidas en el Playbook y garantizar que el sistema esté en el estado deseado.

Ansible fue de vital utilidad para configurar nuestras máquinas virtuales, crear un Cluster de Kubernetes funcional con dichas máquinas y aprovisionar con los diferentes archivos que serán necesarios para la instalación de nuestra plataforma, Kubeflow. En el proceso se definió la estructura de archivos requerida para el funcionamiento de esta herramienta, donde lo más importante a destacar son las "variables de grupo" que nos permitieron hacer un "plantillado" por usuario, de manera de asegurar la reproducibilidad de nuestro experimentos. Por otro lado se definieron "roles" que constan de archivos que contienen instructivos o tareas. Cada rol se puede asignar a "tareas generales" distintas, por lo que es fácil separar el trabajo en secciones más pequeñas que garanticen el entendimiento y por el otro lado, nos permitan aprovisionar "por sección" o "paso a paso" si es que lo deseamos gracias al uso del "tagging" (etiquetado) de dichos roles.

Los roles fueron seccionados en diferentes "etapas de configuración" donde se realizaron, entre otras tareas, la limpieza de viejos archivos de la máquina host, la instalación de multiples dependencias, la configuración del kernel de las máquinas remotas, la instalación de Kubernetes, la inicialización del cluster y la unión de los workers a dicho cluster y la descarga e instalación de los requerimientos de Kubeflow.

Estos roles y sus tareas fueron ordenados y asignados a los diferentes hosts gracias a a un "playbook" principal a partir del cual se seguia el orden de intalación, utilizando los hosts definidos en el "inventario".

Es de mucha importancia aclarar que durante todo el desarrollo del aprovisionamiento se buscó la máxima automatización a la hora de la creación tanto del entorno de pruebas, como del aprovisionamiento en sí.

##### Uso en conjunto - Terraform + Ansible

Terraform y Ansible son dos herramientas complementarias que se utilizan comúnmente juntas para gestionar de manera integral tanto la infraestructura como la configuración de software en un entorno de TI. La combinación de ambas herramientas permite automatizar todo el ciclo de vida de un sistema, desde la creación y aprovisionamiento de la infraestructura hasta la configuración y administración de aplicaciones y servicios en dicha infraestructura. Aquí hay algunas formas típicas en las que se utilizan Terraform y Ansible juntos:

1. **Provisionamiento de infraestructura con Terraform:** Terraform se utiliza para crear y aprovisionar la infraestructura subyacente, como servidores, redes, bases de datos y otros recursos en la nube o en centros de datos locales. Terraform puede configurar la topología de la infraestructura y asegurarse de que los recursos estén disponibles y funcionando según lo previsto.
2. **Configuración de servidores y aplicaciones con Ansible:** Una vez que Terraform ha creado la infraestructura, Ansible se encarga de configurar y gestionar los servidores y aplicaciones en esa infraestructura. Ansible automatiza tareas como la instalación de software, la configuración de archivos de configuración, la aplicación de parches y la gestión de servicios en los servidores.
3. **Orquestación completa de aplicaciones:** Terraform y Ansible se pueden utilizar en conjunto para orquestar la implementación de aplicaciones completas. Terraform puede aprovisionar servidores y recursos, y luego Ansible puede configurar y administrar la aplicación en esos servidores, garantizando que todo el entorno esté funcionando correctamente.
4. **Actualizaciones y cambios en la infraestructura:** Cuando es necesario realizar cambios en la infraestructura, como agregar o quitar servidores, Terraform se encarga de modificar la infraestructura de manera controlada y segura. Luego, Ansible puede aplicar las configuraciones necesarias en los nuevos recursos o realizar ajustes en los recursos existentes para acomodar los cambios.
5. **Automatización de despliegues y escalabilidad:** Terraform y Ansible permiten escalar la infraestructura y las aplicaciones de manera automatizada en función de la demanda. Por ejemplo, cuando se necesita escalar una aplicación web, Terraform puede agregar nuevos servidores, y Ansible puede configurarlos automáticamente para unirse al clúster de aplicaciones existente.
6. **Gestión de la configuración continua:** Ansible se utiliza para garantizar que la configuración de software se mantenga coherente a lo largo del tiempo. Puede aplicar políticas de configuración y asegurarse de que los servidores y las aplicaciones cumplan con los estándares de seguridad y rendimiento.

##### ¿Cómo se comunican Terraform y Ansible para poder realizar las configuraciones?

Tanto Terraform como Ansible son herramientas de automatización que pueden comunicarse con otros sistemas y recursos utilizando diferentes protocolos y mecanismos de autenticación. A continuación, se describen los protocolos y métodos de autenticación comunes utilizados por cada una de estas herramientas:

**Terraform:**

1. **APIs de proveedores de nube:** Terraform se comunica con los proveedores de nube (como AWS, Azure, Google Cloud, etc.) a través de sus respectivas APIs. Estas APIs suelen utilizar protocolos basados en HTTP/HTTPS, como REST o gRPC, para la comunicación. Terraform utiliza las credenciales del proveedor de nube (por ejemplo, las claves de acceso de AWS) para autenticarse y realizar operaciones en la nube.

2. **SSH:** En ocasiones, Terraform puede utilizar SSH para comunicarse con máquinas virtuales o servidores provisionados a través de SSH. En este caso, se utilizan pares de claves SSH (pública y privada) para la autenticación. La clave pública se coloca en el servidor de destino, y la clave privada se utiliza para autenticar la conexión desde Terraform.

**Ansible:**

1. **SSH:** Ansible utiliza SSH como el protocolo predeterminado para conectarse a los servidores de destino y ejecutar comandos o tareas en ellos. Al igual que con Terraform, Ansible utiliza pares de claves SSH (pública y privada) para la autenticación. La clave pública se debe agregar a los servidores de destino y la clave privada se utiliza para autenticar las conexiones desde la máquina que ejecuta Ansible.

2. **WinRM:** Para sistemas Windows, Ansible puede utilizar WinRM (Windows Remote Management) como protocolo de comunicación en lugar de SSH. WinRM permite la administración remota de servidores Windows y utiliza autenticación basada en credenciales (nombre de usuario y contraseña) o certificados.

En cuanto a la comunicación con Proxmox, tanto Terraform como Ansible pueden utilizar SSH para conectarse a los nodos de Proxmox y administrarlos, ya que Proxmox es compatible con SSH para la administración remota. En este caso, se requerirán las claves SSH adecuadas y las configuraciones de acceso para autenticarse en los nodos de Proxmox.

#### Uso de Vagrant como herramienta de Testing local

Durante el proceso de armado de los roles de Ansible y para un trabajo más ordenado e independiente por parte del que desarrolla el aprovisionamiento fue de mucha utilidad el uso de la herramienta de virtualización Vagrant, mediante la cual se desplegaron máquinas virtuales en el entorno local del desarrollador y con esto el mismo fue capaz de probar cada una de las configuraciones realizadas y, en caso de algún inconveniente, borrar y volver a empezar. Por otro lado, nos asegura la reproducibilidad tanto por los otros contribuidores del proyecto, como en el entorno de producción (cluster del laboratorio).

#### Orquestación de contenedores - Kubernetes

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

En estas prácticas se buscó crear un Cluster de Kubernetes en la versión requerida por la plataforma Kubeflow, esta plataforma nos permite lograr escalabilidad de nuestra plataforma según los recursos que se requieran, además, según la cantidad de nodos que tengamos, nuestra plataforma será capaz de ser redundante y permitir que, en el caso de que uno fallase, los pods se generen en otro nodo sin perder la usabilidad de nuestra plataforma. Para la intalación de esta se definieron tres elementos principales:

- La Container Runtime Interface (CRI): Necesitas un container runtime ejecutándose en cada Nodo en tu clúster, de manera que kubelet pueda iniciar los Pods y sus contenedores, por eso CRI es una interfaz de plugin que permite que kubelet use una amplia variedad de container runtimes, sin necesidad de volver a compilar los componentes del clúster. En nuestro caso se eligión CRI-O por su implementación "ligera".

- La Container Network Interface (CNI): Es un marco para configurar dinámicamente los recursos de red. Utiliza un grupo de bibliotecas y especificaciones. La especificación del plugin define una interfaz para configurar la red, aprovisionar direcciones IP y mantener la conectividad con múltiples hosts. Puede integrarse sin problemas con el kubelet para permitir el uso de una red overlay o underlay para configurar automáticamente la red entre pods.

- La StorageClass (SC): Una StorageClass proporciona una forma para que los administradores describan las "clases" de almacenamiento que ofrecen, de esta forma se pueden proveer volúmenes de manera dinámica con ciertas características en particular. En nuestro caso, necesitamos de Rancher para aprovisionar volúmenes de manera Local, ya que Kubernetes tiene diferentes "proveedores" para la creación de estos volúmenes.

### Ejemplo de funcionamiento: Entrenar un modelo

Para instalar Kubeflow necesitamos:

- **Aprovisionamiento de infraestructura:** Creación de los nodos con Terraform o Vagrant.
- **Aprovisionamiento de Sofware:** Configuración de los nodos e instalación de Kubernetes (k8s)
- **Instalación manual de Kubeflow:** Usando los manifests que proporcionan en su repositorio.

#### Aprovisionamiento de infraestructura con Terraform o Vagrant

Tanto como para Vagrant como para Terraform tendremos en cuenta un archivo de configuración principal, `k8s/ansible/group_vars/all.yml`. Dentro del archivo deberemos crear el perfil para nuestra prueba, donde modificaremos diferentes parámetros. En un principio, copiaremos debajo de las existentes y dentro de los usuarios un nuevo usuario con el nombre de nuestra preferencia, quedando con la siguiente forma:

```yml
---
settings:
env: '<nombre-de-nuestro-perfil>'
users:  
    <nombre-de-nuestro-perfil>:
        prod_test: false # Si es Vagrant, false, sino true, esto deshabilita o habilita los reinicios de las VPCs respectivamente para evitar errores.
        
        environment: "" # Variables de entorno que quisieramos agregar a Kubelet
        
        user_dir_path: /home/aagustin # Path al home del local-host
        node_home_dir: /home/vagrant # Path al home del remote-host

        shared_folders:
            - host_path: ./shared_folder # Para Vagrant, indicamos un path respecto a la Vagrantfile del local-host
            vm_path: /home/vagrant # Para Vagrant, indicamos un path donde querramos compartir con el local-host

        cluster_name: Kubernetes Cluster # Para Vagrant, indica el nombre del grupo de VPC's que se va a crear (es visualizable abriendo VirtualBox)
        
        ssh:
            user: "vagrant" # Usuario de SSH configurado en el remote-host
            password: "vagrant" # Clave de SSH configurada en el remote-host
            private_key_path: /home/aagustin/.ssh/vagrant_key # Path a la clave SSH privada guardada en el local-host
            public_key_path: /home/aagustin/.ssh/vagrant_key.pub # Path a la clave SSH pública guardada en el local-host

        nodes:
            control:
                cpu: 4 # Para Vagrant, cores asignados al master
                memory: 4096 # Para Vagrant, memoria asignada al master
            workers:
                count: 2 # Configurar cantidad de Workers
                cpu: 2 # Para Vagrant, cores asignados a los workers
                memory: 4096 # Para Vagrant, memoria asignada a los workers
        
        network:
            control_ip: 192.168.100.171 # Configuración de la IP del nodo master
            dns_servers:
                - 8.8.8.8 # DNS de Google, para acceso a Internet
                - 1.1.1.1 # DNS de Cloudflare, para acceso a Internet
            pod_cidr: 172.16.1.0/16 # No tocar, pool de IP para los pods
            service_cidr: 172.17.1.0/18 # No tocar, pool de IP para los servicios
        

        software:
            box: bento/ubuntu-22.04 # Para Vagrant, imagen a utlizar
            calico: 3.25.0 # Versión de Calico para configurar la red de los Pods
            kubernetes: 1.26.1-00 # Versión de Kubernetes para instalarlo y configurar CRI-O
            os: xUbuntu_22.04 # Versión del SO para configurar CRI-O
            kustomize: 5.0.3 # La versión de Kustomize que requiere Kubeflow 1.8
            kubeflow: 1.8 # La versión del repo de manifests que queremos descargar

```

> **¡IMPORTANTE!** : Recordar seleccionar en la variable `env` nuestro usuario.

##### Vagrant

Habiendo creado nuestro perfil, deberemos tener en cuenta de modificar los siguientes parámetros para nuestra infraestructura:

1. Deshabilitar los reinicios debido a problemas con carpetas compartidas:

    ```yml
    prod_test: false # Si es Vagrant, false, sino true, esto deshabilita o habilita los reinicios de las VPCs respectivamente para evitar errores.
    ```

2. Configuración de SSH:

    ```yml
    ssh:
        user: "vagrant" # Usuario de SSH configurado en el remote-host
        password: "vagrant" # Clave de SSH configurada en el remote-host
        private_key_path: /home/aagustin/.ssh/vagrant_key # Path a la clave SSH privada guardada en el local-host
        public_key_path: /home/aagustin/.ssh/vagrant_key.pub # Path a la clave SSH pública guardada en el local-host
    ```

    > **¡Importante!** Debimos haber creado nuestra clave SSH previamente.

3. Configuración de la cantidad de recursos a asignar a los nodos y la cantidad de nodos:

    ```yml
    nodes:
        control:
            cpu: 4 # Para Vagrant, cores asignados al master
            memory: 4096 # Para Vagrant, memoria asignada al master
        workers:
            count: 2 # Configurar cantidad de Workers
            cpu: 2 # Para Vagrant, cores asignados a los workers
            memory: 4096 # Para Vagrant, memoria asignada a los workers
    ```

4. Configuración de red:

    ```yml
    network:
        control_ip: 192.168.100.171 # Configuración de la IP del nodo master
    ```

    > **¡Importante!** En el caso de Vagrant, no es necesario que sea una IP de la red de nuestra LAN, debido a que se creará una nueva red privada para los nodos.

5. Configuración del sistema:

    ```yml
    software:
        box: bento/ubuntu-22.04 # Para Vagrant, imagen a utlizar
    ```

Finalmente, podemos levantar nuestros nodos con la Vagrantfile:

```sh
# Posicionados en <repo-dir>/kubernetes/k8s/
vagrant up
```

En el caso de necesitar destruir las máquinas virtuales:

```sh
# Posicionados en <repo-dir>/kubernetes/k8s/
vagrant destroy
```

##### Terraform

En nuestro caso nos encontramos aprovisionando infraestructura utilizando como base la plataforma de virtualización Proxmox, donde tendremos disponible ciertos recursos que destinaremos a la creación de los nodos (máquinas virtuales) mediante Terraform utilizando de provider justamente a Proxmox.

Además de modificar el archivo de `k8s/ansible/group_vars/all.yml`, deberemos modificar nuestros archivos de `<project-dir>/terraform/`.

Comenzaremos modificando los valores de los archivos de `<project-dir>/terraform/`:

1. Modificamos el archivo `<project-dir>/terraform/main.tf`:

    ```ruby
    terraform {
    required_providers {
        proxmox = {
        source  = "telmate/proxmox" # Seleccionamos el provider de proxmox
        version = "2.9.11"
        }
    }
    }

    provider "proxmox" {

    pm_debug = true
    pm_api_url = "https://192.168.100.100:8006/api2/json" # 
    pm_api_token_id = "terraformuser@pam!terraformuser_token" # Usuario Proxmox hardcodeado
    pm_api_token_secret = "..." # Token de proxmox hardcodeado
    pm_tls_insecure = true
    pm_log_levels = {
        _default    = "debug"
        _capturelog = ""
        }
    }


    resource "proxmox_vm_qemu" "vms-pps" {

    count       = length(var.proxmox_nodes)
    name        = "k8spps${count.index+1}" # Modificamos el nombre de nuestras vm's
    desc        = "k8s pps" # Modificamos la descripción de nuestras vm's
    vmid      = "70${count.index+1}" # Modificamos el ID de nuestras vm's
    target_node = var.proxmox_nodes[count.index] # Creará los nodos según la lista en el archivo 'vars.tf'
    clone       = var.template_name
    agent       = 1
    os_type     = "cloud-init"
    cores       = 8 # Modificamos la cantidad de núcleos de nuestras vm's
    sockets     = 1
    cpu         = "host"
    memory      = 8192  # Modificamos la cantidad de memoria de nuestras vm's
    onboot      = true
    scsihw      = "virtio-scsi-single"
    bootdisk    = "scsi0"

    disk {
        size     = "20G" # Modificamos la cantidad de almacenamiento de nuestras vm's
        type     = "scsi"
        storage  = "local-lvm"
        iothread = 1
    }

    network {
        model  = "virtio"
        bridge = "vmbr0"
    }
    
    lifecycle {
        ignore_changes = [
        network,
        ]
    }

    ipconfig0   = "ip=192.168.100.17${count.index+1}/24,gw=192.168.100.1" # Modificamos las IP's de nuestras vm's
    nameserver  = "192.168.100.1" # Modificamos el GW de nuestras vm's

    }
    ```

2. Modificamos el archivo `<project-dir>/terraform/vars.tf`:

    ```ruby
    variable "ssh_key" {
    default = "ssh-rsa ..." # Copiamos nuestra clave privada SSH
    }

    variable "proxmox_nodes" {
    type    = list(string)
    default = ["controlador", "nodo1", "nodo2"] # Le damos un nombre a cada nodo y definimos la cantidad añadiendo o quitando elementos a esta lista
    }

    variable "template_name" {
        default = "ubuntu-2204-template-labredes-pass-key-sudoer-nopasswd" # Elegimos la template a utilizar
    }
    ```

3. El archivo `<project-dir>/terraform/create_template.sh` nos permite hacer modificaciones en las mismas máquinas virtuales durante su creación, es un conjunto de comandos que nos permitirá, por ejemplo, darle permisos de super-usuario al usuario o inyectarle las claves públicas SSH a los known-host. **Modificaremos este archivo en caso de que cambiemos de cluster o movamos de lugar las claves SSH, las nombremos de manera distinta o necesitemos cambiar el nombre de la carpeta del usuario.** Las líneas que deberemos modificar en este caso son las siguientes:

    ```sh
    sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'useradd -m -s /bin/bash labredes' # Para añadir el usuario "labredes"
    sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'echo "labredes:labredes" | chpasswd' # Para añadirle la contraseña "labredes" al usuario "labredes"
    sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'usermod -aG sudo,adm labredes' # Para darle permisos de administrador y super-usuario al usuario "labredes"
    sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'mkdir -p /home/labredes/.ssh' # Para crear la carperta del usuario en home y la carpeta .ssh
    sudo virt-customize -a jammy-server-cloudimg-amd64.img --ssh-inject labredes:file:/root/.ssh/id_key_labredes.pub # Para inyectar la clave pública
    sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'chown -R labredes:labredes /home/labredes/.ssh' # Para cambiar la propiedad de la carpeta home al usuario "labredes"
    sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'echo "labredes ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers' # Para permitir al usuario "labredes" ejecutar comandos sudo sin escribir 'sudo <command>'
    ```

Finalmente, aplicamos los siguientes comandos de Terraform:

a. Para inicializar un directorio de trabajo de Terraform. Descargar y configurar los proveedores de infraestructura necesarios, así como cualquier módulo de Terraform que esté siendo utilizado. Es el primer comando que se debe ejecutar al trabajar con un nuevo proyecto de Terraform.

```sh
# Posicionados en <project-dir>/terraform/
terraform init
```

b. Para crear un plan de ejecución detallado de los cambios que se aplicarán a la infraestructura. Examinar los archivos de configuración de Terraform y determinar qué recursos se crearán, modificarán o eliminarán. El plan también muestra los valores de los atributos de los recursos y cualquier cambio propuesto.

```sh
# Posicionados en <project-dir>/terraform/
terraform plan
```

c. Para aplicar los cambios definidos en el archivo de configuración de Terraform y realizar las acciones necesarias para lograr el estado deseado de la infraestructura. Terraform leerá el plan generado por el comando terraform plan y solicitará confirmación antes de aplicar los cambios. Una vez confirmado, Terraform creará, modificará o eliminará los recursos según lo especificado.

```sh
# Posicionados en <project-dir>/terraform/
terraform apply
```

Ahora, modificando los valores de `k8s/ansible/group_vars/all.yml`:

1. Habilitar los reinicios de las VPCs:

    ```yml
    prod_test: true # Si es Vagrant, false, sino true, esto deshabilita o habilita los reinicios de las VPCs respectivamente para evitar errores.
    ```

2. Configuración de SSH:

    ```yml
    ssh:
        user: "labredes" # Usuario de SSH configurado en el remote-host
        password: "labredes" # Clave de SSH configurada en el remote-host
        private_key_path: /home/aagustin/.ssh/cluster_key # Path a la clave SSH privada guardada en el local-host
        public_key_path: /home/aagustin/.ssh/cluster_key.pub # Path a la clave SSH pública guardada en el local-host
    ```

    > **¡Importante!** Debimos haber creado nuestra clave SSH previamente.

3. Aquí solo deberemos modificar la cantidad de nodos (sin borrar nada de lo otro):

    ```yml
    nodes:
        workers:
            count: 2 # Configurar cantidad de Workers
    ```

4. Configuración de red:

    ```yml
    network:
        control_ip: 192.168.100.171 # Configuración de la IP del nodo master
    ```

#### Aprovisionamiento de software con Ansible

Aquí simplemente modificamos, tanto como si utilizamos Vagrant o Terraform, los siguientes valores de `k8s/ansible/group_vars/all.yml`:

1. Seleccionamos las versiones de los diferentes elementos:

    ```yml
   software:
        calico: 3.25.0 # Versión de Calico para configurar la red de los Pods
        kubernetes: 1.26.1-00 # Versión de Kubernetes para instalarlo y configurar CRI-O
        os: xUbuntu_22.04 # Versión del SO para configurar CRI-O
        kustomize: 5.0.3 # La versión de Kustomize que requiere Kubeflow 1.8
        kubeflow: 1.8 # La versión del repo de manifests que queremos descargar
    ```

Además deberemos modificar el inventario en ambos casos, en nuestro caso, para ser pŕacticos separamos en dos inventarios correspondientes a las prubas locales (`ansible/inventory_local.yml`) y las pruebas de laboratorio (`ansible/inventory_lab.yml`). Modificaremos el que corresponda como sigue:

```yml
---

all:
  children:
    kube_master:
      hosts:
        master-node-171:
          ansible_host: "{{ CONTROL_IP }}"
    kube_workers:
      hosts:
        worker-node-172:
            ansible_host: "{{ IP_SECTIONS }}172"
        worker-node-173:
            ansible_host: "{{ IP_SECTIONS }}173"
        ...
        ...
        worker-node-17N:
            ansible_host: "{{ IP_SECTIONS }}17N"
```

> **¡Importante!** Como vemos, añadiremos tantos worker-node's como hayamos creado en la sección de infraestructura y deberemos asignar *manualmente* la IP de HOST correspondiente a cada uno.

Comprobamos conexión con los nodos con el módulo `ping`:

```sh
# Posicionados en <repo-dir>/kubernetes/k8s/
ansible -i ansible/inventory_<local o lab>.yml -m ping all
```

> Deberíamos ver PING con respuesta PONG de cada uno de los nodos que hayamos creado.

Finalmente, para correr hacer el aprovisionamiento de Software ejecutamos el siguiente comando:

```sh
# Posicionados en <repo-dir>/kubernetes/k8s/
ansible-playbook -vvv ansible/site.yml -i ansible/inventory_<local o lab>.yml
```

> **-vvv**: Indica el nivel de Verbose (logs) que veremos, podríamos no usar ese parámetro si no quisiéramos demasiados logs.

> **¡Importante!** Debemos además seleccionar el inventario según corresponda.

#### Instalación manual de Kubeflow

Para la instalación de Kubeflow tenemos dos métodos: Paquetizado para diferentes plataformas o mediante los manifest (inistalación manual). En nuestro caso, al hacer una instalación local y limpia (bare-metal) de Kubernetes, **vamos a utilizar la segunda, mediante sus manifests**, los cuales se encuentran en su [repositorio](https://github.com/kubeflow/manifests).

Necesitaremos elegir la versión que nos convenga, en nuestro caso, utlizaremos la más reciente a la fecha que es la correspondiente a la branch `v1.8-branch` del correspondiente repositorio. Seleccionaremos dicha branch para observar los requerimientos.

Leeremos el README para poder seguir el instructivo de instalación, pero para también poder ver los pre-requisitos que nos solicita Kubeflow para su funcionamiento.

> **¡Importante!** Trabajaremos en el directorio `~/` del nodo master, ingresaremos mediante SSH al mismo:
>
> ```sh
> ssh -i ~/.ssh/key <user>@<IP-master>
> ```

Si observamos, a la fecha y para dicha versión nos pide:

![Pre-Requisitos](img/kf-prerequisites.png)

El primer requisito, de la versión de Kubernetes, está cubierto debido a que hemos instalado la misma, nos falta definir una Default StorageClass.

> **¿Qué es una StorageClass?** Las clases de almacenamiento de Kubernetes proporcionan una forma de aprovisionar dinámicamente almacenamiento persistente para aplicaciones que se ejecutan en un clúster de Kubernetes. Cada StorageClass contiene los campos provisioner, parameters y reclaimPolicy, que se utilizan cuando un PersistentVolume que pertenece a la clase debe aprovisionarse dinámicamente.
>
> ![StorageClass](img/kubernetes-sc.png)

El segundo requisito es tener Kustomize instalado, esto nos permitirá la aplicación de las configuraciones (`kubectl apply ...`) de Kubernetes de manera automatizada.

Y por último, nos pide tener Kubectl, el cual está cubierto ya que se ha instalado durante el aprovisionamiento de Software.

Habiendo hecho el aprovisionamiento con Ansible nos habremos asegurado de tener la Local StorageClass agregada y por defecto, de tener Kustomize instalado y de tener el repositorio correspondiente a los manifests de la versión deseada ya descargado, por lo que nos queda instalar manualmente Kubeflow en nuestro Cluster. Para ello tenemos dos caminos, la instalación en un solo comando o la intalación módulo a módulo. Elegiremos la segunda por una cuestión de asegurarnos la correcta instalación paso a paso de cada uno de los módulos.

1. Accedemos a la carpeta de los manifests:

    ```sh
    # Posicionados en ~/
    cd manifests
    ```

    > **¡Importante!** Se recomienda instalar comando a comando, tomando su tiempo en cada uno para checkear que se hayan levantado todos los pods, pudiendo visualizar todo esto desde el dashboard. Además, puede que algunos elementos de la instalación, como el Authservice no se inicien hasta que no hayamos levantado el siguiente, Dex en este caso. Por lo que se recomienda continuar si Eventos corresponden a errores de Webhooks. Ante la duda, podemos hacer la instalación de un solo comando que figura en el mismo repositorio.

2. Instalamos el cert-manager:

    ```sh
    kustomize build common/cert-manager/cert-manager/base | kubectl apply -f -
    kubectl wait --for=condition=ready pod -l 'app in (cert-manager,webhook)' --timeout=180s -n cert-manager
    kustomize build common/cert-manager/kubeflow-issuer/base | kubectl apply -f -
    ```

    Checkeamos que todos los pods estén creados y corriendo:

    ```sh
    watch kubectl get pods -n cert-manager
    ```

3. Instalamos Istio:

    ```sh
    kustomize build common/istio-1-17/istio-crds/base | kubectl apply -f -
    kustomize build common/istio-1-17/istio-namespace/base | kubectl apply -f -
    kustomize build common/istio-1-17/istio-install/base | kubectl apply -f -
    ```

    Checkeamos que todos los pods estén creados y corriendo:

    ```sh
    watch kubectl get pods -n istio-system
    ```

4. Instalamos el AuthService:

    ```sh
    kustomize build common/oidc-client/oidc-authservice/base | kubectl apply -f -
    ```

    Checkeamos que todos los pods estén creados y corriendo:

    ```sh
    watch kubectl get pods -n auth
    ```

5. Instalamos Dex:

    ```sh
    kustomize build common/dex/overlays/istio | kubectl apply -f -
    ```

6. Instalamos K-Native Serving

    ```sh
    kustomize build common/knative/knative-serving/overlays/gateways | kubectl apply -f -
    kustomize build common/istio-1-17/cluster-local-gateway/base | kubectl apply -f -
    ```

    Checkeamos que todos los pods estén creados y corriendo:

    ```sh
    watch kubectl get pods -n knative-eventing
    ```

    Y también:

    ```sh
    watch kubectl get pods -n knative-serving
    ```

7. Creamos el namespace de Kubeflow:

    ```sh
    kustomize build common/kubeflow-namespace/base | kubectl apply -f -
    ```

8. Instalamos los Kubeflow Roles:

    ```sh
    kustomize build common/kubeflow-roles/base | kubectl apply -f -
    ```

    Checkeamos que todos los pods estén creados y corriendo:

    ```sh
    watch kubectl get pods -n kubeflow
    ```

9. Creamos los recursos de Istio:

    ```sh
    kustomize build common/istio-1-17/kubeflow-istio-resources/base | kubectl apply -f -
    ```

    Checkeamos que todos los pods estén creados y corriendo:

    ```sh
    watch kubectl get pods -n istio-system
    ```

10. Creamos las Pipelines de Kubeflow

    ```sh
    kustomize build apps/pipeline/upstream/env/cert-manager/platform-agnostic-multi-user | kubectl apply -f -
    ```

    Checkeamos que todos los pods estén creados y corriendo:

    ```sh
    watch kubectl get pods -n kubeflow
    ```

11. Checkeamos la creación de los pods del ejemplo:

    ```sh
    watch kubectl get pods -n kubeflow-user-example-com
    ```

#### Crear servicio para exponer el Dashboard de Kubeflow a la IP del nodo

##### Exponer el servicio (port-forward) - No recomendado

```sh
kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
```

##### Exponer el servicio (NodePort) - Recomendado

1. Creamos el siguiente archivo para el servicio servicio `forwarding-svc.yaml`:

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
    name: custom-pf-svc
    namespace: istio-system
    spec:
    type: NodePort
    ports:
        - targetPort: 8080 # Where the other service is listening
        port: 80  # Where this service are available inside the cluster
        nodePort: 30002 # Where to expose this service
    selector:
        app: istio-ingressgateway  # Service to expose 
    ```

2. Aplicamos la configuración:

    ```sh
    kubectl apply -f forwarding-svc.yaml
    ```

3. Buscamos la IP (url) donde está expuesto:

    ```sh
    # Caso de que no funcione el comando, ingresamos a la IP del nodo y al puerto configurado.
    kubectl get service -n istio-system custom-pf-svc --url
    ```

4. Ingresamos a la url que nos muestra.

#### Correr ejemplo

Una vez hayamos ingresado a Kubeflow con nuestra usuario y contraseña de ejemplo: `user@example.com` y `12341234`.

> **¡Importante!** Como vamos a trabajar sobre HTTP y no sobre HTTPS deberemos modificar la variable de entorno de `APP_SECURE_COOKIES` y setearla en `false` en cada web app que necesitemos, en nuestro caso será para Notebooks. De todas maneras no es recomendado por riesgos de seguridad. Para nuestro ejemplo:
>
> ```sh
> kubectl edit deploy jupyter-web-app-deployment -n kubeflow
> ```
>
> Y este también:
>
> ```sh
> kubectl edit deploy volumes-web-app-deployment -n kubeflow
> ```

1. Seleccionamos nuestro namespace (en nuestro caso el ejemplo que viene desplegado con la instalación)

    ![Kubeflow Example 1](img/kubeflow-example-1.png)

2. Ingresar a Kubeflow en su sección "Notebooks"

    ![Kubeflow Example 2](img/kubeflow-example-2.png)

3. Crear un Nuevo Notebook Server haciendo clicl en "+ New Notebook"

    ![Kubeflow Example 3](img/kubeflow-example-3.png)

4. Elegimos un nombre para el Notebook Server, un entorno, el tipo de imágen, la cantidad de CPU's y RAM del mismo:

    ![Kubeflow Example 4](img/kubeflow-example-4.png)

5. En nuestro caso no utilizamos GPU y crearemos un nuevo volumen para el mismo:

    ![Kubeflow Example 5](img/kubeflow-example-5.png)

6. Hacemos click en "Lauch":

    ![Kubeflow Example 6](img/kubeflow-example-6.png)

7. Esperamos que esté Ready y hacemos Click en "Connect"

    ![Kubeflow Example 7](img/kubeflow-example-7.png)

8. Copiamos el siguiente código en el notebook:

    [Basic classification: Classify images of clothing](https://www.tensorflow.org/tutorials/keras/classification)

    ![Kubeflow Example 8-a](img/kubeflow-example-8-a.png)

    ![Kubeflow Example 8-b](img/kubeflow-example-8-b.png)

> **¡Importante!** Con *Ctrl + S* podemos guardar el notebook creado, a partir de acá nos manejamos como si tuvieramos Notebook en local. Tambien recordar instalar dependencias abriendo una consola desde le mismo Notebook Server (boton + arriba a la izquierda)

#### Extra: Instalación local con Minikube

Si deseamos correr en local con Minikube, podemos seguir los sigueintes pasos:

##### Instalación del binario

```sh
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

##### Configuración de alias para kubectl

```sh
alias kubectl="minikube kubectl --"
```

##### Despliegue de 1 nodo

```sh
minikube start --kubernetes-version='1.26.1' --memory='12288' --cpus='8' --disk-size='80GB' --vm=true
minikube addons enable metrics-server
```

> **¡Importante!** La cantidad de CPUs es como mínimo de 8, sino no se levantarán todos los servicios. La RAM es como mínimo de 12HB y el almacenamiento debe ser de como mínimo de 60GB.

##### Detener la ejecución del Cluster

```sh
minikube stop --all
```

##### Visualización

Desde otra terminal o antes de empezar podemos correr el Dashboard con el siguiente comando:

```sh
minikube dashboard
```

##### Instalación de Kustomize

1. Descarga de instalador

    ```sh
    wget https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh
    ```

2. Instalación de versión 5.0.3

    ```sh
    chmod +x install_kustomize.sh
    ./install_kustomize.sh 5.0.3
    chmod +x kustomize
    mv kustomize /usr/local/bin
    ```

##### Descarga de los manifiestos

```sh
git clone https://github.com/kubeflow/manifests.git -b v1.8-branch
cd manifests/
```

##### Instalación de un solo comando (aprox 40min)

```sh
while ! kustomize build example | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done
```

##### Exposición de servicio dentro del cluster (port-forward)

```sh
kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
```

##### Exponer fuera del cluster (NodePort)

1. Creamos el siguiente archivo para el servicio servicio `forwarding-svc.yaml`:

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
    name: custom-pf-svc
    namespace: istio-system
    spec:
    type: NodePort
    ports:
        - targetPort: 8080 # Where the other service is listening
        port: 80  # Where this service are available inside the cluster
        nodePort: 30001 # Where to expose this service
    selector:
        app: istio-ingressgateway  # Service to expose 
    ```

2. Aplicamos la configuración:

    ```sh
    kubectl apply -f forwarding-svc.yaml
    ```

3. Buscamos la IP (url) donde está expuesto:

    ```sh
    minikube service -n istio-system custom-pf-svc --url
    ```

4. Ingresamos a la url que nos muestra.

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
