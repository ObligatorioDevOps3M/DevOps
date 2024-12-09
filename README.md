![ort_logo](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/diagramas/ort_logo.jpg)

<h1 align="center">Documentación de obligatorio - Certificado en DevOps 2024</h1>
<p align="center"><b>Martín Rivero</b> – <b>Matías Dadomo</b> - <b>Martín Orue</b></p>
<p align="center"><b>Grupo 8</b></p>
<p><b>Tutor: Federico Barceló</b></p>

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
- [Mejoras a futuro](#mejoras-a-futuro)
- [Uso de la IA](#uso-de-la-ia)

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

![imagen Kanban GitHub Projects](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/images/kanban.png)
[Enlace al Kanban](https://github.com/orgs/ObligatorioDevOps3M/projects/3/views/3 "https://github.com/orgs/obligatoriodevops3m/projects/3/views/3")
## Flujos de trabajo en Git

Para el control de versionado seleccionamos Git porque es el más difundido y con el que tenemos más familiaridad, utilizando Github para alojar los repositorios. La decisión se tomó para aprovechar la integración con las demás herramientas.
### Equipo Desarrollo

#### GitFlow

Se utilizó GitFlow como estrategia para el manejo de ramas, definiendo main, staging y develop como ramas estables. 
Para las nuevas funcionalidades se utilizan ramas efímeras `feature/<nueva_funcionalidad>` que luego se fusionan con develop, desde la cual se hacen releases al resto de las ramas estables. 
Para solucionar bugs en producción, se utilizan ramas llamadas `hotfix`.

![diagrama GitFlow](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/diagramas/GitFlow.png)
### Equipo DevOps

#### Trunk Based

Se utiliza Trunk Based para manejar las ramas del repositorio DevOps, por ser una estrategia más simple en la cual se parte de una rama estable "main" y se utilizan ramas efímeras `feature/<nueva_funcionalidad>` para los nuevos desarrollos, que luego se integran a la rama principal.

![diagrama Trunk base](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/diagramas/DevOps.png)

## Infraestructura como código (IaC)

La infraestructura fue diseñada utilizando **Terraform**, que permite definir recursos en un entorno de nube mediante código, logrando configuraciones mantenibles, replicables y escalables. Se utilizó **AWS** como proveedor de Cloud, por ser una opción estándar en la industria y contar con créditos proporcionados por la universidad.

A continuación, se detalla la estructura general de la infraestructura creada y sus componentes principales:

### Subida de Aplicaciones en Contenedores

- **Imágenes Docker**: Las aplicaciones backend se empaquetan en contenedores Docker. Las imágenes se almacenan en **Amazon Elastic Container Registry (ECR)**. Creamos un repositorio por aplicación y manejamos los entornos usando tags.
- **Kubernetes en AWS**: Se implementa un clúster de **Amazon Elastic Kubernetes Service (EKS)** para orquestar los contenedores.
    - **Node Groups**: Se define un grupo de nodos y se configura el escalado con la cantidad mínima y máxima de instancias.
    - **Instancias t2.micro**: Para abaratar costos, se utilizan instancias de tipo **spot** como nodos de trabajo.
    - **Despliegue de Servicios**: Kubernetes genera los servicios necesarios para exponer las aplicaciones, tanto a nivel interno como externo, que se generan en los deploys de los repositorios al hacer merge en una rama estable.

### Networking

Se hicieron configuraciones básicas de red para permitir el acceso a la infraestructura:
- **Subredes**: se crearon subredes privadas para albergar las instancias.
- **Tabla de ruteo**: se definieron rutas para comunicación entre subredes y acceso a Internet.
- **Grupos de seguridad**: se asignaron reglas que restringen el tráfico entrante y saliente según puertos y direcciones IP.
- **Internet Gateway**: se crea un punto de acceso para las instancias que necesitan conectarse a Internet.

### API Gateway

Para centralizar el acceso a las APIs:

- **Definición de rutas**: se crean rutas específicas para cada microservicio del backend.
- **Integraciones**: Las rutas del API Gateway se integran con los servicios desplegados en el clúster EKS.

![Diagrama infra](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/diagramas/Infra_v2.png)

### Implementación por Etapas

La infraestructura fue implementada en dos etapas:

1. **Configuración Base**: se crea clúster EKS, se configuran de redes, y despliegue inicial de los servicios utilizando Terraform. Como salida en este paso, obtenemos archivos de configuración donde guardamos las URLs de los repositorios ECR. Usamos GitHub para almacenar y compartir esta información con el resto de los pipelines de los repositorios de las aplicaciones.
2. Deploy inicial: se ejecutan los pipelines de CI/CD de las apliaciones backend de forma manual para construir los servicios que consumiremos posteriormente. Es necesario hacerlo en orden, dejando por último el BackendOrdersService, dado que el mismo depende de los anteriores servicios.
3. **Integración y Ajustes**: creación de API Gateway y creación de las rutas asociadas a los servicios creados en el paso anterior. Las URLs se obtienen desde archivos de configuración en el repositorio DevOps.
### Despliegue de Frontend

El frontend de la aplicación se despliega en **Amazon S3**, utilizando buckets configurados para servir contenido estático.

- **Buckets por entorno**: Cada entorno (`production`, `staging`, `develop`) tiene su propio bucket.
- Se le aplica a cada bucket políticas de seguridad que permiten el acceso a su contenido desde Internet.

![Diagrama deploy](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/diagramas/Deploy_v4.png)
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
Se construye una imágen de Docker que incluye variables de entorno, y la sube a un repositorio en Amazon ECR. Luego, despliega la aplicación en un clúster AWS EKS aplicando configuraciones actualizadas de Kubernetes.
 
Finalmente, genera la URL del servicio desplegado y la guarda en el repositorio centralizado para ser utilizada como insumo en el paso siguiente.
 
#### Explicación de api-testing.yml
 
En este workflow se ejecutan pruebas de integración de las APIs y sus servicios relacionados. 
Se activa con _push_ o _pull request_ en ramas específicas (`main`, `staging`, `develop` y `feature/*`). Inicialmente, identifica la rama activa y clona cuatro repositorios de microservicios (`Orders`, `Products`, `Payments` y `Shipping`), asegurándose de trabajar en las ramas adecuadas.
 
Se compilan todos los microservicios en archivos JAR y los empaqueta en imágenes Docker.
 
Posteriormente, crea una red Docker compartida, levanta contenedores de los servicios interconectados y espera a que se inicien. Luego, instala **Newman** para ejecutar pruebas de integración mediante una colección Postman, simulando interacciones entre servicios.
 
![captura estructura directorios](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/images/directoriosBack.png)
 
### Frontend
 
Para el pipeline de CI/CD de los respositorios de backend, se crearon los archivos: `build-and-deploy-to-s3.yml` y `build-and-test.yml`.
#### Explicación de build-and-deploy-to-s3.yml
 
En este workflow se automatiza la construcción, pruebas y despliegue de una aplicación web a un bucket de **Amazon S3**.
 
Se activa con _push_ o _pull request_ en ramas específicas (`main`, `staging`, `develop` y `feature/*`), y utiliza Node.js para instalar dependencias, ejecutar pruebas y construir la aplicación. Luego, clona un repositorio externo para obtener configuraciones específicas del entorno, como el nombre del bucket de S3, según la rama activa. Configura credenciales de AWS y sincroniza el contenido generado de la carpeta `dist/apps/catalog` con el bucket correspondiente, eliminando archivos obsoletos en S3.
 
Este flujo permite desplegar automáticamente la aplicación en diferentes entornos (`production`, `staging`, `develop`), para asegurar la actualización del contenido en cada cambio.
 
#### Explicación de build-and-test.yml
 
En este workflow se automatiza la construcción y pruebas de una aplicación Node.js. Se activa con _push_ en las ramas `main`, `staging`, `develop`, `feature/*` y `test`. Realiza los siguientes pasos: clona el código del repositorio, configura Node.js (versión 20.14.0), instala las dependencias necesarias mediante `npm install`, ejecuta las pruebas unitarias con `npm test` y construye la aplicación con `npm run build`.

![captura directorios](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/images/directoriosFront.png)

![Diagrama de flujo de CI_CD](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/diagramas/CI-CD.png)
## Test

### Análisis de código estático

Para hacer análisis de código estático usamos `SonarCloud`.
Se integró `SonarCloud` con los repositorios del equipo de desarrollo tanto frontend como para backend.

![imagen evidencia SonarCloud](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/images/sonarCloudDashboard.png)
![Segunda imagen evidencia SonarCloud](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/images/sonarCloudOrders.png)
[Enlace a la organización de SonarCloud](https://sonarcloud.io/organizations/obligatoriodevops3m13112024/projects)
### Pruebas unitarias
Para pruebas unitarias usamos `JUnit` en backend y Jest en el frontend, que se ejecutan en los pipelines de CI/CD.

![captura JUnit](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/images/testJUnit.png)
![Captura Jest](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/images/testJest.png)

### API Testing

Se implementó un workflow que ejecuta pruebas de integración de las APIs. 
 
Se construyen imágenes de Docker, se crea una red Docker compartida y se levantan contenedores de los servicios interconectados. 

Luego, se utiliza **Newman** para ejecutar pruebas de integración mediante una colección Postman para simular la interacción entre servicios.

![Test con Newman](https://github.com/ObligatorioDevOps3M/DevOps/blob/main/images/testNewman.png)

## Mejoras a futuro

En función de las oportunidades detectadas durante la implementación, a continuación se enumeran las posibles mejoras para el proyecto:

1. **Quitar Repeticiones de Código**:
    
    - Identificar patrones repetidos en los workflows y agruparlos en **acciones reutilizables** o scripts comunes.

2. **Extraer Lógicas Bash en Archivos Independientes**:
    
    - Crear scripts bash dedicados en una carpeta `scripts` dentro de los repositorios.
    - Estos scripts pueden ser llamados desde los workflows, logrando mayor modularización

3. **Separar Etapas de Build, Test y Deploy**:
    
    - Implementar un enfoque modular en los workflows: dividir las etapas de **build**, **test**, y **deploy** en workflows separados.

4. **Limitar Deploys a Ramas Estables**:
    
    - Configurar workflows de despliegue para que se activen únicamente con _merge_ en ramas estables (`main`, `staging`, `develop`).

5. **Separar Infraestructura por Entornos**:
    
    - Evitar compartir infraestructura entre entornos para no crear problemas a nivel de estado de Terraform que tienen que mitigarse con código adicional

## Uso de la IA

- Acelerar búsquedas para dudas específicas (ej.: comandos Docker y cómo hacer un trim de un string en código Terraform)
- Preguntas conceptuales del estilo: "cómo se integran Terraform y los deploy de EKS"
- Preguntas sobre buenas prácticas (estructura de directorios, criterios para nombrar recursos en Terraform y taguear imágenes)
