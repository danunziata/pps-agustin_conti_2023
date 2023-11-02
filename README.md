
<a name="top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/danunziata/pps-agustin_conti_2023/tree/main">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">PPS Agustin Aguilera Conti</h3>

  <p align="center">
    Despliegue de plataforma para desarrollo, entrenamiento e implementación de modelos de machine learning en cloud computing
    <br />
    <a href="https://github.com/danunziata/pps-agustin_conti_2023/tree/main"><strong>Mirá la documentación acá »</strong></a>
    <br />

  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Tabla de contenidos</summary>
  <ol>
    <li>
      <a href="#sobre-el-proyecto">Sobre el proyecto</a>
      <ul>
        <li><a href="#componentes">Componentes</a></li>
      </ul>
    </li>
    <li>
      <a href="#para-comenzar">Para comenzar</a>
      <ul>
        <li><a href="#prerequisitos">Prerequisitos</a></li>
        <li><a href="#instalación">Instalación</a></li>
      </ul>
    </li>
    <li><a href="#uso">Uso</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contribuir">Contribuir</a></li>
    <li><a href="#licencia">Licencia</a></li>
    <li><a href="#contacto">Contacto</a></li>
    <li><a href="#referencias">Referencias</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## Sobre el proyecto

[![MLOps Header][mlops-header]](https://www.arrikto.com/mlops-explained/)

Como objetivo general de este proyecto buscamos **explorar, evaluar** un conjunto de tecnologías esenciales que permiten la implementación exitosa de prácticas de Machine Learning Operations (MLOps) en el entorno universitario, haciendo hincapié en la **reutilización, la reproducibilidad y la escalabilidad.**

La **implementación de sistemas de MLOps** se ha vuelto cada vez más crucial, ya que proporciona la infraestructura necesaria para respaldar a los científicos y expertos en la universidad en su búsqueda de soluciones basadas en Machine Learning. Facilita la gestión eficiente del ciclo de vida de los modelos, desde su desarrollo y entrenamiento hasta su despliegue y monitoreo, permitiendo así la reutilización de los recursos, la reproducibilidad de los resultados y la escalabilidad de las soluciones.

Dentro de este documento se encontrarán las bases necesarias para poder contribuir al proyecto, crear el entorno de trabajo y realizar una prueba de lo estudiado. Para mayor información se puede consultar la [documentación completa](#documentacion-completa).

[Back to Top](#top)

### Componentes

Se listan a continuación las tecnologías utilizadas.

* [![Terraform][Terraform]][Terraform-url]
* [![Ansible][Ansible]][Ansible-url]
* [![Kubernetes][Kubernetes]][Kubernetes-url]
* [![Docker][Docker]][Docker-url]
* [![Python][Python]][Python-url]
* [![Tensorflow][Tensorflow]][Tensorflow-url]
* [![Pytorch][Pytorch]][Pytorch-url]

[Back to Top](#top)

<!-- GETTING STARTED -->
## Para comenzar

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisitos

Aca debo listar todo lo que se debe descargar para luego poder instalar y hacer funcionar el proyecto

  ```sh
  apt install some-library
  ```

### Instalación

Dejamos un ejemplo del clonado e instalación de dependencias del proyecto

1. Clonar el repositorio

   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```

2. Some instruction

   ```sh
   ...
   ```

[Back to Top](#top)

<!-- USAGE EXAMPLES -->
## Uso

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

Para mas ejemplos e información, por favor diríjase a la [Documentación](https://example.com).

[Back to Top](#top)

<!-- ROADMAP -->
## Roadmap

* [x] Documentos inicio PPS

* [x] Selección del Workflow de GIT

* [x] Armar el Readme del Repo, contexto y como reproducir el ambiente

* [x] Búsqueda y revisión bibliográfica. Contextualización

* [ ] Investigación y evaluación de la herramienta

* [ ] Diseño e implementación de la infraestructura basada en Kubeflow

* [ ] Desarrollo de pipelines de flujo de trabajo

* [ ] Integración de modelos de Machine Learning en los pipelines

* [ ] Pruebas y ajustes de los pipelines

* [ ] Redacción de documentación e informe

Mire el [proyecto](https://github.com/users/danunziata/projects/4) para el listado completo de actividades y el checkeo de su estado actual.

[Back to Top](#top)

<!-- CONTRIBUTING -->
## Contribuir

### Flujo de trabajo

El proceso que seguiremos implica utilizar la rama `main` como la rama de **producción** del proyecto. Cualquier nueva funcionalidad o corrección de errores se realizará creando nuevas ramas.

Para incorporar una función en la rama `main`, simplemente se crea un "PR" (Pull Request), que deberá ser aprobado por algún colaborador, cualquier colaborador puede hacerlo, o bien, si no requiere revisión, puede ser aceptado por quien esté incluyendo la funcionalidad.

Es crucial que el nombre de las ramas creadas sea lo más descriptivo posible. Por ejemplo, si trabajamos en una nueva funcionalidad relacionada con la API, la rama se debe llamar `feature-api`. En el caso de tratarse de la corrección de un error en el código de la API, la llamaremos `fix-api`.

Además, se contarán con ramas específicas para la documentación con Mkdocs, denominadas `docs`, y para el README, que se llamará `readme`.

La duración de cada rama dependerá de la necesidad de trabajo. Por ejemplo, las ramas `readme` y `docs` podrían mantenerse en remoto sin eliminarse durante todo el trabajo. Luego, se pueden añadir nuevos commits a ellas y volver a crear un "PR". En contraste, al trabajar con partes de la base de datos o la API, las ramas deberán durar hasta la finalización de la funcionalidad, para luego eliminarse del repositorio remoto y continuar con una nueva rama para cualquier otra nueva característica.

### Creación y publicación de ramas

Para crear una nueva rama desde tu entorno local:

```sh
git checkout -b <nombre-de-la-nueva-rama> <nombre-de-la-rama-origen>
```

Para publicar la nueva rama en el repositorio remoto:

```sh
# en <nombre-de-la-nueva-rama>
git push --set-upstream origin <nombre-de-la-nueva-rama>
```

### Solicitud de PRs

Para solicitar un PR, recomendamos realizarlo directamente desde la interfaz de GitHub.

![Crear una PR - Paso 1/2](images/create-pr-1.png)

![Crear una PR - Paso 2/2](images/create-pr-2.png)

Finalmente, haz clic en "Create pull request" y espera la aprobación.

### Commits convencionales

Los commits convencionales nos permiten mantener la organización al realizar los commits y facilitan la creación de `releases` de forma automatizada.

Se basan en el uso de palabras clave al inicio del mensaje de cada commit, de la siguiente manera:

* **feat(tema de la modificación): Breve explicación**: Para cambios significativos o nuevas características.
  
* **chore(tema de la modificación): Breve explicación**: Para cambios menores, como modificar una IP para una prueba local.
  
* **fix(tema de la modificación): Breve explicación**: Para correcciones pequeñas, como agregar acentos en la documentación.

Ejemplo:

```
feat(vagrant): Añadiendo archivo de configuración de Vagrant
```

Además, es importante **sectorizar por tema** los commits. Por ejemplo, si tu commit modifica 3 archivos relacionados con la API y uno con la documentación, al realizar el commit de la API, `feat(API)`, **no agregaremos a la etapa de preparación** el archivo de documentación, solo los 3 archivos de la API.

### Eliminación de ramas del repositorio remoto y sincronización del repositorio local

Para eliminar las ramas obsoletas del repositorio remoto, se realizará a través de la interfaz de GitHub, en la sección `Branches`.

![Eliminar rama - Paso 1/3](images/delete-branch-1.png)

Luego, se accede a ver todas las ramas:

![Eliminar rama - Paso 2/3](images/delete-branch-2.png)

Finalmente, se hace clic para eliminar la rama:

![Eliminar rama - Paso 3/3](images/delete-branch-3.png)

Una vez eliminada la rama, si se desea, se puede sincronizar el entorno local siguiendo estos pasos:

* Listar las ramas que pueden ser eliminadas del entorno local:

  ```sh
  git remote prune origin --dry-run
  ```

* Limpiar las referencias locales:

  ```sh
  git remote prune origin
  ```

* Verificar el estado de las ramas locales:

  ```sh
  git branch -a
  ```

  Se comprobará que la rama remota ha sido eliminada, pero la rama local aún permanece.

* Eliminar la rama local:

  ```sh
  git branch -d <nombre-de-la-rama-a-borrar>
  ```

Con estos pasos, el entorno local estará "sincronizado" con el remoto.

### Uso del entorno virtual de Python - Poetry

Para el entorno virtual de Python del proyecto, utilizamos Poetry. Esto nos permite trabajar con las mismas dependencias. Una vez instalado en tu PC y situado en el directorio del proyecto:

* Para añadir nuevas dependencias:

  ```sh
  poetry add <nombre-de-la-dependencia>
  ```

* Para ejecutar un programa utilizando las dependencias del entorno:

  ```sh
  poetry run <comando-para-ejecutar-nuestro-programa>
  ```

Siempre utilizaremos el mismo entorno virtual. No se creará uno por carpeta, sino que todas las ejecuciones y adiciones de dependencias serán sobre el mismo archivo `.toml` creado en el directorio del proyecto.

### Documentación temporal

Cada vez que se cree una nueva funcionalidad, en la rama correspondiente y en el directorio respectivo, se debe crear una documentación temporal. Esto se realiza para evitar la pérdida de información al trasladarla a la documentación general en Mkdocs.

La idea es crear un archivo Markdown dentro del directorio en el que se está trabajando con el siguiente nombre: `temp_docs_<nombre-de-la-funcionalidad-o-corrección>.md`.

Este archivo será temporal y servirá para que aquellos que trabajen en la documentación de Mkdocs tengan toda la información a su alcance.

Este archivo puede publicarse en la rama `main`. Solo se eliminará una vez se haya trasladado a la documentación general.

[Back to Top](#top)

<!-- LICENSE -->
## Licencia

Este proyecto se distribuye bajo los términos de la Licencia Pública General de GNU, versión 3.0 (GNU General Public License, version 3.0). Consulta el archivo [LICENSE](LICENSE) para obtener detalles completos.

### Resumen de la Licencia

La Licencia Pública General de GNU, versión 3.0 (GNU GPL-3.0), es una licencia de código abierto que garantiza la libertad de uso, modificación y distribución del software bajo los términos estipulados en la licencia. Requiere que cualquier software derivado se distribuya bajo los mismos términos de la GPL-3.0. Consulta el archivo [LICENSE](LICENSE) para más información sobre los términos y condiciones.

### Aviso de Copyright

El aviso de copyright para este proyecto se encuentra detallado en el archivo [LICENSE](LICENSE).

[Back to Top](#top)

<!-- CONTACT -->
## Contacto

Agustín Aguilera Conti - [aagustinconti.com.ar](https://aagustinconti.com.ar) - <mail@aagustinconti.com.ar>

Link del proyecto: [https://github.com/danunziata/pps-agustin_conti_2023/](https://github.com/danunziata/pps-agustin_conti_2023/tree/main)

[Back to Top](#top)

<!-- ACKNOWLEDGMENTS -->
## Referencias

Encontrá información importante en:

* [Kubeflow](https://v0-7.kubeflow.org/docs/)

[Back to Top](#top)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[mlops-header]: images/mlops-header.png

[TensorFlow]: https://img.shields.io/badge/TensorFlow-%23FF6F00.svg?style=for-the-badge&logo=TensorFlow&logoColor=white
[Tensorflow-url]: https://tensorflow.org
[Docker]: https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white
[Docker-url]: https://docker.com
[Pytorch]:https://img.shields.io/badge/PyTorch-%23EE4C2C.svg?style=for-the-badge&logo=PyTorch&logoColor=white
[Pytorch-url]: https://pytorch.org/
[Kubernetes]: https://img.shields.io/badge/kubernetes-326ce5.svg?&style=for-the-badge&logo=kubernetes&logoColor=white
[Kubernetes-url]: https://kubernetes.io
[Ansible]: https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white
[Ansible-url]: https://www.ansible.com/
[Terraform]: https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white
[Terraform-url]: https://www.terraform.io/
[Python]: https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue
[Python-url]: https://www.python.org/
