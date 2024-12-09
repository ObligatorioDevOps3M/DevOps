## Carátula
Universidad ORT Uruguay
Facultad de Ingeniería
Documentación de obligatorio
Certificado en DevOps
Estudiantes grupo 8
Martín Rivero – Matías Dadomo - Martín Orue
Tutor: Federico Barceló 
2024

## Índice
- [Presentación del problema](#presentación-del-problema)
- [Objetivos](#objetivos)
- [Propuesta](#propuesta)
- [Herramientas seleccionadas](#herramientas-seleccionadas)
- [Planificación del equipo](#planificación-del-equipo)
- [Flujos de trabajo en Git](#flujos-de-trabajo-en-git)
  - [Equipo Desarrollo](#equipo-desarrollo)
    - [GitFlow](#gitflow)
  - [Equipo DevOps](#equipo-devops)
    - [Trunk Based](#trunk-based)
- [Infraestructura como código (IaC)](#infraestructura-como-código-iac)
  - [Utilizar IaC y desplegar la infraestructura en AWS](#utilizar-iac-y-desplegar-la-infraestructura-en-aws)
- [CI/CD](#cicd)
  - [Backend](#backend)
    - [Explicación de build-and-deploy.yml](#explicación-de-build-and-deployyml)
    - [Explicación de api-testing.yml](#explicación-de-api-testingyml)
  - [Frontend](#frontend)
    - [Explicación de build-and-deploy-to-s3.yml](#explicación-de-build-and-deploy-to-s3yml)
    - [Explicación de build-and-test.yml](#explicación-de-build-and-testyml)
- [Test](#test)
  - [Análisis de código estático](#análisis-de-código-estático)
  - [Pruebas unitarias](#pruebas-unitarias)
  - [API Testing](#api-testing)
---
## Presentación del problema

En el proceso de transformación digital de una empresa líder en retail, surgió un desafío crítico relacionado con la falta de integración y colaboración efectiva entre los equipos de desarrollo y operaciones. Este problema se evidenció durante el lanzamiento de una nueva aplicación que buscaba mejorar la experiencia del cliente, donde despliegues frecuentes resultaron en errores y caídas del sistema, afectando tanto a los usuarios como a la reputación de la empresa.

El análisis reveló que las dificultades no eran meramente técnicas, sino culturales y organizativas. La separación tradicional de responsabilidades entre desarrollo y operaciones fomentó una desconexión que impedía la responsabilidad compartida y el entendimiento mutuo. Mientras desarrollo priorizaba la velocidad de entrega, operaciones se enfocaba en la estabilidad, generando tensiones y reacciones descoordinadas ante los problemas.

Reconociendo la raíz del problema, la dirección ejecutiva decidió impulsar un cambio cultural profundo que unificara objetivos y prácticas entre los equipos, promoviendo una cultura de colaboración y aprendizaje continuo. Se solicitó un plan de acción estratégico que incluya:

1. **Mejoras en la comunicación y colaboración** entre los equipos.
2. **Eliminación de barreras organizativas** que dificulten la integración de flujos de trabajo.
3. **Fomento de prácticas que promuevan una comprensión mutua** de los desafíos y objetivos compartidos.

---
## Objetivos

El objetivo de este trabajo es superar los problemas actuales planteados anteriormente y construir una base para la agilidad y resiliencia operativa a largo plazo, asegurando la posición competitiva de la empresa en el mercado.

En base a lo mencionado anteriormente, el equipo se propone cumplir con los siguientes objetivos:

- Utilizar IaC y desplegar la infraestructura en AWS.
- Implementar un ciclo completo de CI/CD para cada aplicación, tanto de backend como de frontend, incluyendo análisis de código estático y testing automatizado.
- Utilizar metodologías de trabajo alineadas con la cultura DevOps.

---
## Propuesta

Nuestra propuesta consiste en reformular la forma de trabajo actual tanto del equipo de desarrollo como del equipo de operaciones, para adoptar el modelo DevOps. 
Con esto buscamos implementar una serie de prácticas, herramientas, y metodologías para disminuir el *time-to-market* y mejorar la calidad del software entregado.

## Herramientas seleccionadas

A continuación se detalla la lista de herramientas y tecnologías seleccionadas para la implementación del proyecto:

- AWS como proveedor de Cloud, EKS como orquestador de contenedores, ECR como repositorio de imágenes y API Gateway como serverless.
- Terraform como herramienta de IaC
- GitHub Actions para correr pipelines de CI/CD
- Docker para creación de imágenes y contenedores
- SonarCloud como herramienta de análisis de código estático
- Postman/Newman para testing automatizado de APIs

## Planificación del equipo

Usaremos Github Projects. Evaluamos Azure Devops y Trello, pero nos decidimos por esta herramienta porque está integrada a repositorios de Github. Resultó muy sencillo y rápido configurar un tablero Kanban que se ajuste a nuestra planificación por sprint (1 semana). También nos resultó atractivo el nivel de integración con el resto de herramientas de Github que usaremos.

TODO: imagen Kanban GitHub Projects.
[Enlace al Kanban](https://github.com/orgs/ObligatorioDevOps3M/projects/3/views/3 "https://github.com/orgs/obligatoriodevops3m/projects/3/views/3")
## Flujos de trabajo en Git

Para el control de versionado seleccionamos Git porque es el más difundido y con el que tenemos más familiaridad, utilizando Github para alojar los repositorios. La decisión se tomó para aprovechar la integración con las demás herramientas.
### Equipo Desarrollo

#### GitFlow

Se utilizó GitFlow como estrategia para el manejo de ramas, definiendo main, staging y develop como ramas estables. 
Para las nuevas funcionalidades se utilizan ramas efímeras `feature/<nueva_funcionalidad>` que luego se fusionan con develop, desde la cual se hacen releases al resto de las ramas estables. 
Para solucionar bugs en producción, se utilizan ramas llamadas `hotfix`.

TODO: diagrama GitFlow
### Equipo DevOps

#### Trunk Based

Se utiliza Trunk Based para manejar las ramas del repositorio DevOps, por ser una estrategia más simple en la cual se parte de una rama estable "main" y se utilizan ramas efímeras `feature/<nueva_funcionalidad>` para los nuevos desarrollos, que luego se integran a la rama principal.

TODO: diagrama Trunk base

## Infraestructura como código (IaC)

Optamos por AWS por ser un estándar popular, además de ser el servicio en el que contamos con créditos asignados por la universidad.

-  AWS EKS - Deploy imágenes
-  AWS ECR - Deploy de recursos
-  AWS S3 - Deploy Frontend
-  Docker
-  Terraform
-  AWS API Gateway

TODO: diagrama infra

A continuación haremos un repaso de los cambios sugeridos:
### Utilizar IaC y desplegar la infraestructura en AWS.

Para construir la infraestructura utilizamos Infraestructura como código (IaC), haciéndola más mantenible y escalable, además de replicable y bien documentada.
A raíz de esto, se decidió utilizar `Terraform` como herramienta de `IaC` y `AWS` como nube para alojar los recursos definidos.

## CI/CD

`Github Actions` fue la herramienta seleccionada para la integración del código por su nivel de integración con las otras herramientas y por ser tendencia en la industria. 

Otra herramienta evaluada fue `Jenkins`, pero fue descartada por la complejidad en su configuración y la lentitud en su funcionamiento. 

Con Continuous Integration y Continuous Delivery, se busca implementar mecanismos que mejoren el time-to-market, así como la automatización de los procesos de build, test y deploy de los distintos aplicativos.

En cada proyecto se creó una carpeta `.github`, y dentro una carpeta `.workflow`. Allí se definen los archivos `.yml` que especifican los pasos que se ejecutarán al interactuar con las ramas (push, pull request y merge) .

### Backend

Para el pipeline de CI/CD de los respositorios de backend, se crearon los archivos: `build-and-deploy.yml` y `api-testing.yml`.

#### Explicación de build-and-deploy.yml

En este workflow se automatiza la construcción, prueba, empaquetado y despliegue de una aplicación Java. Se activa con _push_ o _pull request_ en ramas específicas (`main`, `staging`, `develop` y `feature/*`) y comienza configurando el entorno con JDK Corretto 8 y Maven para compilar y probar el proyecto. 

Según la rama, determina el entorno (`production`, `staging` o `develop`) y clona un repositorio externo para obtener configuraciones y URLs de servicios relacionados. 
Configura credenciales de AWS para construir una imagen Docker personalizada, que incluye variables de entorno, y la sube a un repositorio en Amazon ECR. Luego, despliega la aplicación en un clúster AWS EKS aplicando configuraciones actualizadas de Kubernetes. 

Finalmente, genera la URL del servicio desplegado y la guarda en el repositorio externo para mantener sincronización entre entornos.

#### Explicación de api-testing.yml

En este workflow se ejecutan pruebas de integración de las APIs y sus servicios relacionados. 
Se activa con _push_ o _pull request_ en ramas específicas (`main`, `staging`, `develop` y `feature/*`). Inicialmente, identifica la rama activa y clona cuatro repositorios de microservicios (`Orders`, `Products`, `Payments` y `Shipping`), asegurándose de trabajar en las ramas adecuadas. 

Configura JDK Corretto 8 y Maven para compilar cada microservicio, empaqueta los archivos JAR generados y los prepara para la construcción de imágenes Docker.

Posteriormente, crea una red Docker compartida, levanta contenedores de los servicios interconectados y espera a que se inicien. Luego, instala **Newman** para ejecutar pruebas de integración mediante una colección Postman, simulando interacciones entre servicios. Finalmente, detiene y elimina los contenedores y la red Docker para mantener el entorno limpio.

TODO: captura estructura directorios

### Frontend

Para el pipeline de CI/CD de los respositorios de backend, se crearon los archivos: `build-and-deploy-to-s3.yml` y `build-and-test.yml`.
#### Explicación de build-and-deploy-to-s3.yml

En este workflow se automatiza la construcción, pruebas y despliegue de una aplicación web a un bucket de **Amazon S3**. 

Se activa con _push_ o _pull request_ en ramas específicas (`main`, `staging`, `develop` y `feature/*`), y utiliza Node.js para instalar dependencias, ejecutar pruebas y construir la aplicación. Luego, clona un repositorio externo para obtener configuraciones específicas del entorno, como el nombre del bucket de S3, según la rama activa. Configura credenciales de AWS y sincroniza el contenido generado de la carpeta `dist/apps/catalog` con el bucket correspondiente, eliminando archivos obsoletos en S3. 

Este flujo permite desplegar automáticamente la aplicación en diferentes entornos (`production`, `staging`, `develop`), para asegurar la actualización del contenido en cada cambio.

#### Explicación de build-and-test.yml

En este workflow se automatiza la construcción y pruebas de una aplicación Node.js. Se activa con _push_ en las ramas `main`, `staging`, `develop`, `feature/*` y `test`. Realiza los siguientes pasos: clona el código del repositorio, configura Node.js (versión 20.14.0), instala las dependencias necesarias mediante `npm install`, ejecuta las pruebas unitarias con `npm test` y construye la aplicación con `npm run build`.

TODO: captura directorios front
TODO: diagrama de flujo de CI/CD
## Test

### Análisis de código estático

Para hacer análisis de código estático usamos `SonarCloud`.
Se integró `SonarCloud` con los repositorios del equipo de desarrollo tanto frontend como para backend.

TODO: imagen evidencia SonarCloud
[Enlace a la organización de SonarCloud](https://sonarcloud.io/organizations/obligatoriodevops3m13112024/projects)
### Pruebas unitarias
Para pruebas unitarias usamos `JUnit` en backend y Jest en el frontend, que se ejecutan en los pipelines de CI/CD.

TODO: captura JUnit
TODO: captura Jest

### API Testing

Se implementó un workflow que ejecuta pruebas de integración de las APIs. 
 
Se construyen imágenes de Docker, se crea una red Docker compartida y se levantan contenedores de los servicios interconectados. 

Luego, se utiliza **Newman** para ejecutar pruebas de integración mediante una colección Postman para simular la interacción entre servicios.

TODO: imágenes de test con Newman






