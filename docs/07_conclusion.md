# Conclusión

Se concluye que se lograron satisfactoriamente los objetivos planteados en el proceso de implementación de las prácticas. La utilización de herramientas como Vagrant para la virtualización y prueba local de roles de Ansible demostró ser beneficiosa, permitiendo a los desarrolladores realizar configuraciones y pruebas de manera eficiente.

La incorporación de Kubernetes como plataforma de orquestación de contenedores en la implementación de Kubeflow destaca la orientación hacia soluciones modernas y escalables. La creación de un clúster de Kubernetes con CRI-O como interfaz de contenedores, CNI para la configuración dinámica de red, y StorageClass para la gestión dinámica de almacenamiento evidencian una arquitectura bien estructurada.

En el ejemplo específico de Kubeflow, la instalación se divide en pasos claros, desde el aprovisionamiento de la infraestructura hasta la instalación manual de los manifestos proporcionados. Esta metodología asegura un despliegue controlado y la replicabilidad del entorno, tanto en el desarrollo como en el entorno de producción.

El uso de Terraform para el aprovisionamiento de infraestructura con Proxmox demuestra un enfoque integral en la automatización, facilitando la creación y gestión de nodos de manera eficiente.

Además, la estructura detallada de la configuración, como la definición de perfiles en archivos YAML, proporciona flexibilidad y facilita la personalización según las necesidades del proyecto. La inclusión de consideraciones de seguridad, como la configuración de claves SSH y la administración de usuarios, muestra un compromiso con las mejores prácticas.

En resumen, la adopción de tecnologías y prácticas modernas, junto con la atención a detalles como la configuración de red, recursos de hardware y seguridad, reflejan un enfoque integral y bien planificado en el desarrollo e implementación de las prácticas. Este enfoque contribuye a la eficiencia, escalabilidad y replicabilidad de las soluciones propuestas.
