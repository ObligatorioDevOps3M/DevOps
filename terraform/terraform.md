
## Creación de Entornos con Terraform

### Definición de Infraestructura

Se define la creación de varios elementos de infrastructura en AWS para cada entorno.

  

- EKS
- ECR
- VPC
- 2 sub redes en distintas zonas de disponibilidad.
- etc.

Y se genera un flujo de creación de infraestructura y creación de archivos de configuración de acuerdo al siguiente diagrama:

![Diagrama de Terraform](/diagramas/Terraform.png)

### Configurar Variables

Se crearon archivos para manejar las variables de entrada y salida.

#### Entradas

inputs.tf define las variables de entrada.

Para cada entorno tenemos un archivo distinto con valores de entrada pre definidos.

1. develop.tfvars

2. staging.tfvars

3. production.tfvars

  
  

No olvidar configurar el rol en cada uno de ellos:

`role_arn = "arn:aws:iam::xxxxxxxx:role/LabRole"`

  

*Tienen que tener las mismas variables todos.*

  

#### Salidas

outputs.tf define las variables de salida.

  

Si necesito que terraform me devuelva valores (ej URL de recursos creados).

  

1. Agrego una entrada en outputs.tf para declarar la variable de

salida.

2. Agrego una línea en build.sh para obtener el raw output de

ese dato y escribirlo en un archivo de salida. Este último se puede

leer desde cada repo.

*terraform output -raw <nombre-de-variable> >./options-"$1"/<nombre-de-variable>.txt*

Ej.: `terraform output -raw ecr_repository_uri >./options-"$1"/ecr_repository_uri.txt`

  

### Scripts

Se crean archivos para facilitar la construcción y destrucción de la infraestructura.

Esto es para no tener que escribir los cambios de workspace ni agregar parámetros que pueden pre definirse.

#### Construir

build.sh. Automatiza la creación de la infra definida en *main.tf*.

  

El uso es: *./build.sh < nombre-entorno >*

Ej.: `./build.sh develop`

#### Destruir

destroy.sh. Automatiza la destrucción de la infra definida en *main.tf*.

El uso es: *./destroy.sh < nombre-entorno >*

Ej.: `./destroy.sh develop`