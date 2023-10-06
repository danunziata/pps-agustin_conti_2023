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

### Metodologías ágiles

#### Manifiesto ágil

El Manifiesto Ágil es un documento que establece los valores y principios fundamentales para el desarrollo ágil de software. Fue creado en 2001 por un grupo de expertos en desarrollo de software que buscaban alternativas más flexibles y eficientes a los enfoques tradicionales de gestión de proyectos.

**Valores del Manifiesto Ágil:**

1. **Individuos e interacciones sobre procesos y herramientas:** Se enfoca en la importancia de las personas y la comunicación efectiva en el desarrollo de software.
2. **Software funcionando sobre documentación extensiva:** Prioriza la entrega de software funcional y utilizable por encima de una documentación exhaustiva.
3. **Colaboración con el cliente sobre negociación contractual:** Destaca la importancia de la colaboración continua con el cliente para adaptarse a los cambios y requisitos emergentes.
4. **Responder a cambios sobre seguir un plan:** Aboga por la flexibilidad y la capacidad de adaptarse a cambios en los requisitos, incluso en etapas avanzadas del desarrollo.

**Principios del Manifiesto Ágil:**

1. **La más alta prioridad es satisfacer al cliente mediante la entrega temprana y continua de software valioso.**
2. **Aceptar cambios en los requisitos, incluso en etapas tardías del desarrollo.**
3. **Entregar software funcional con frecuencia, con preferencia a intervalos cortos.**
4. **Colaborar con clientes y usuarios a lo largo del proyecto.**
5. **Construir proyectos alrededor de individuos motivados, dándoles el entorno y el apoyo que necesitan y confiando en ellos para que hagan el trabajo.**
6. **El método más eficiente y efectivo de comunicación es la conversación cara a cara.**
7. **El software funcional es la principal medida de progreso.**
8. **Mantenerte enfocado en la simplicidad, maximizando la cantidad de trabajo no realizado.**
9. **Las mejores arquitecturas, requisitos y diseños surgen de equipos autoorganizados.**
10. **A intervalos regulares, el equipo reflexiona sobre cómo ser más efectivo y ajusta su comportamiento en consecuencia.**

Hoy en día, el Manifiesto Ágil sigue siendo un marco de referencia influyente para el desarrollo de software. Las metodologías ágiles como Scrum, Kanban y XP (eXtreme Programming) se basan en estos valores y principios. Las organizaciones adoptan enfoques ágiles para mejorar la flexibilidad, la capacidad de respuesta a cambios y la entrega continua de software de alta calidad. Además, la cultura ágil ha trascendido el ámbito del desarrollo de software y se ha extendido a otras áreas como la gestión de proyectos, el marketing y la gestión empresarial.

#### Scrum: Roles y responsabilidades

Scrum es un marco de trabajo ágil que se utiliza comúnmente en el desarrollo de software para gestionar proyectos de manera iterativa e incremental. Los roles en Scrum son esenciales para la colaboración y la entrega efectiva de productos. Los roles principales en Scrum y sus responsabilidades son:

1. **Product Owner (Dueño del Producto):**
    - *Responsabilidades:*
        - Define la visión del producto.
        - Prioriza el backlog del producto.
        - Asegura que el equipo esté trabajando en las características más valiosas y prioritarias.
        - Toma decisiones sobre el alcance y las características del producto.
2. **Scrum Master (Facilitador del Proceso):**
    - *Responsabilidades:*
        - Garantiza que el equipo Scrum siga las prácticas y reglas de Scrum.
        - Facilita las reuniones del equipo, como las reuniones de planificación, revisión y retrospectiva.
        - Elimina los obstáculos que impiden el progreso del equipo.
        - Ayuda a mantener un entorno de trabajo colaborativo y centrado en la entrega de valor.
3. **Equipo de Desarrollo:**
    - *Responsabilidades:*
        - Desarrolla el producto durante los sprints.
        - Colabora en la planificación del sprint y define las tareas necesarias.
        - Se autoorganiza para lograr los objetivos del sprint.
        - Participa en las ceremonias de Scrum, como las reuniones diarias de scrum, la revisión y la retrospectiva.

Es importante destacar que en Scrum, se fomenta la colaboración y la autogestión del equipo. El Product Owner y el Scrum Master sirven al equipo y trabajan en conjunto para asegurar que el producto se desarrolle de manera efectiva y que se cumplan los objetivos del negocio. Además, Scrum promueve la transparencia, la inspección y la adaptación continua, lo que permite a los equipos responder rápidamente a los cambios en los requisitos o en el entorno del proyecto.

En Scrum, tanto el "Backlog" como el "Sprint" son conceptos fundamentales que contribuyen al enfoque iterativo e incremental del desarrollo de software.

1. **Backlog:**
    
    El "Product Backlog" (Backlog del Producto) es una lista dinámica y priorizada de todas las funcionalidades, mejoras y tareas que podrían ser realizadas para un producto. Es responsabilidad del Product Owner mantener y gestionar este backlog. Algunas características del Product Backlog incluyen:
    
    - **Priorización:** Las ítems del backlog están ordenados por prioridad, con las características más importantes o de mayor valor para el cliente en la parte superior.
    - **Flexibilidad:** El backlog es flexible y puede cambiar con el tiempo para adaptarse a las necesidades cambiantes del negocio o del cliente.
    - **Detalles:** Los elementos del backlog no necesitan estar detallados en exceso. Los detalles se refinan a medida que los elementos se acercan al tope del backlog y se preparan para ser incluidos en un sprint.
2. **Sprint:**
    
    Un "Sprint" es una unidad de tiempo fija y corta durante la cual se realiza un trabajo específico y se produce una versión potencialmente entregable del producto. Los sprints en Scrum generalmente tienen una duración de dos a cuatro semanas. Algunas características clave del Sprint incluyen:
    
    - **Objetivo del Sprint:** Antes de comenzar un Sprint, el equipo selecciona elementos del Product Backlog para incluir en el Sprint Backlog, que es la lista de elementos que se comprometen a completar durante el sprint.
    - **Iterativo e Incremental:** El trabajo se realiza en ciclos iterativos, y al final de cada Sprint, se produce un incremento potencialmente entregable del producto.
    - **Reuniones:** Durante el sprint, el equipo se reúne diariamente en la "Daily Scrum" para revisar el progreso y planificar el trabajo del día.
    - **Revisión y Retrospectiva:** Al final del Sprint, se llevan a cabo la "Sprint Review" para presentar el trabajo completado y obtener retroalimentación, y la "Sprint Retrospective" para analizar el proceso y mejorar en futuros sprints.

La combinación del Backlog y los Sprints permite a los equipos Scrum mantener un enfoque ágil y responder rápidamente a los cambios en los requisitos del cliente o del negocio, al tiempo que entrega de manera regular incrementos de valor al producto.

Para nuestro caso, el tutor docente actuaría como Scrum Master, el tutor externo actuaría de Product Owner y el equipo de desarrollo estaría conformado por el alumno. Además hemos definido los **sprints de una semana**, y tomaremos tareas del backlog que se ha conformado a partir del plan de trabajo de esta PPS.

#### Cultura DevOps

La cultura DevOps es una filosofía y práctica que promueve la colaboración estrecha y continua entre los equipos de desarrollo (Dev) y operaciones (Ops) en el ciclo de vida del desarrollo de software. El objetivo principal es superar las barreras tradicionales entre estos dos departamentos para lograr una entrega de software más rápida, eficiente y confiable.

**Principios y Valores de la Cultura DevOps:**

1. **Colaboración y Comunicación:**
    - *Principio:* Fomentar la colaboración abierta y una comunicación efectiva entre los equipos de desarrollo y operaciones.
2. **Automatización:**
    - *Principio:* Automatizar tanto como sea posible los procesos de desarrollo, prueba y despliegue para mejorar la eficiencia y reducir errores.
3. **Entrega Continua:**
    - *Principio:* Buscar la entrega continua de software, permitiendo versiones pequeñas y frecuentes en lugar de despliegues masivos y menos frecuentes.
4. **Monitoreo y Retroalimentación:**
    - *Principio:* Implementar sistemas de monitoreo para obtener retroalimentación rápida sobre el rendimiento y la calidad del software en producción.
5. **Responsabilidad Compartida:**
    - *Principio:* Fomentar una mentalidad de responsabilidad compartida entre los equipos de desarrollo y operaciones en todo el ciclo de vida del software.

**Cómo se utiliza hoy en día:**

La cultura DevOps se implementa mediante la adopción de prácticas y herramientas específicas, como:

- **Despliegue Continuo (Continuous Deployment):** Automatización del proceso de liberación de software para que nuevas versiones puedan ser implementadas de manera rápida y segura.
- **Infraestructura como Código (Infrastructure as Code - IaC):** Definir y gestionar la infraestructura de manera automatizada, tratándola como código, lo que facilita la reproducibilidad y escalabilidad.
- **Integración Continua (Continuous Integration):** Integrar el código de los desarrolladores en un repositorio compartido varias veces al día, lo que facilita la detección temprana de errores.
- **Monitoreo Continuo y Análisis de Logs:** Utilizar herramientas para monitorear el rendimiento en tiempo real y analizar los registros para identificar problemas y áreas de mejora.

A modo de síntesis, la cultura DevOps busca mejorar la colaboración, eficiencia y velocidad en el desarrollo y despliegue de software, y se apoya en la automatización, la entrega continua y la responsabilidad compartida entre los equipos de desarrollo y operaciones.

#### Objetivos SMART

Los objetivos SMART son una metodología utilizada para establecer metas y objetivos de manera clara y específica. El acrónimo SMART representa los criterios que deben cumplir estos objetivos:

1. **Específicos (Specific):** Los objetivos deben ser claros y específicos, evitando ambigüedades y definiciones vagas.
2. **Medibles (Measurable):** Deben incluir criterios cuantificables para evaluar el progreso y determinar cuándo se ha alcanzado el objetivo.
3. **Alcanzables (Achievable):** Los objetivos deben ser realistas y alcanzables dentro del contexto y recursos disponibles.
4. **Relevantes (Relevant):** Deben estar alineados con los objetivos generales y estratégicos de la organización.
5. **Temporizables (Time-bound):** Deben tener un plazo o período de tiempo específico para su cumplimiento.

Relacionando los objetivos SMART con Scrum en el contexto de Backlog, Sprint o Tarea:

- **Backlog:** Los elementos del Product Backlog en Scrum se benefician al ser definidos de manera SMART. Cada elemento debe ser específico en cuanto a su funcionalidad, medible en términos de valor para el usuario, alcanzable dentro del alcance del proyecto, relevante para los objetivos del producto y con un plazo temporal definido.
- **Sprint:** Los objetivos de cada Sprint, establecidos durante la planificación del Sprint, también pueden seguir la metodología SMART. Al ser específicos, medibles, alcanzables, relevantes y temporizables, estos objetivos guiarán el trabajo del equipo durante el Sprint.
- **Tarea:** Incluso a nivel de tareas individuales dentro de un Sprint, la aplicación de la metodología SMART puede ser útil. Cada tarea puede ser definida de manera específica, medible en términos de esfuerzo o resultados, alcanzable para un miembro del equipo, relevante para los objetivos del Sprint y con un plazo temporal asignado.

La aplicación de objetivos SMART en Scrum contribuye a una mayor claridad, enfoque y medición del progreso en el desarrollo de software, alineando los esfuerzos del equipo con metas claras y alcanzables.

#### A modo de síntesis

Las metodologías ágiles, encabezadas por el Manifiesto Ágil, han transformado la forma en que se aborda el desarrollo de software al promover valores como la flexibilidad, la colaboración y la entrega continua de valor al cliente. SCRUM, una de las metodologías ágiles más populares, opera bajo los principios del Manifiesto Ágil y estructura el desarrollo en sprints, con roles claramente definidos y un enfoque en la transparencia y adaptabilidad. La cultura DevOps, por otro lado, se alinea con los principios ágiles al fomentar la colaboración estrecha entre los equipos de desarrollo y operaciones, buscando la automatización y la entrega continua. En este contexto, los objetivos SMART se integran como una metodología clave para establecer metas claras, medibles y alcanzables, proporcionando un marco estructurado que puede aplicarse tanto a la gestión del backlog en SCRUM como a los objetivos específicos de cada sprint. La combinación de metodologías ágiles, SCRUM, la cultura DevOps y objetivos SMART crea un entorno de desarrollo flexible, colaborativo y orientado a resultados, permitiendo a los equipos adaptarse rápidamente a los cambios, mejorar continuamente y cumplir con los objetivos estratégicos de la organización.