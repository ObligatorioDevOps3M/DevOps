## Herramientas y justificación del uso

A continuación se detalla la lista de herramientas y tecnologías seleccionadas para la implementación del proyecto.

### Planificación

Usaremos Github Projects. Evaluamos Azure Devops y Trello. Pero nos decidimos por esta herramienta porque está integrada a repositorios de Github. Resultó muy sencillo y rápido configurar un tablero Kanban que se ajuste a nuestra planificación por sprint (1 semana). También nos resultó atractivo el nivel de integración con el resto de herramientas de Github que usaremos. 

### Code

Para el control de versionado seleccionamos Git porque es el más difundido y con el que tenemos más familiaridad, utilizando Github para alojar los repositorios. La decisión se tomó siguiendo la línea de seguir aprovechando la integración de las herramientas. Y por nuestro interés en profundizar el aprendizaje.

### Build

Github Actions fue la herramienta seleccionada para la integración del código por su nivel de integración con las otras herramientas y por ser tendencia en la industria. 

Otra herramienta evaluado fue Jenkins. Pero fue descartada por la complejidad en su configuración y la lentitud de funcionamiento. 

### Test

Para pruebas unitarias usaremos Junit ya que son las que fueron codeadas en la aplicación. Y para pruebas funcionales de backend seleccionamos Newman para ejecutar los casos de prueba desde el pipeline. **(TODO)**  

Para hacer análisis de código estático usaremos Sonar Cloud. 


### CI/CD

Siguiendo la lógica de puntos anteriores. Seleccionamos GitHub actions por el nivel de integración con las otras herramientas. Además de soportar la implementación de estrategias de integración y despliegue del código.

### Deploy
**(TODO)**  
Kubernetes
Docker
Ansible
Terraform
AWS CodeDeploy
OpenShift
Rancher
Nomad
Chef
Puppet

## Cloud

Optamos por AWS por ser un estándar popular y es el servicio con el que contamos créditos asignados por la universidad.


