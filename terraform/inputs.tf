# Archivo de variables de entrada
# Pasar valores de variables al llamar el comando:
#   terraform apply -var="region=us-east-1" -var="app_name=orders"
# Pasar valores usando archivo de valores:
#   terraform apply -var-file="develop.tfvars"
# Se pueden combinar:
#   terraform apply -var-file="develop.tfvars" -var="app_name=orders"

variable "environment" {
  description = "Nombre del entorno. Valores: develop, staging, production."
  type        = string
}

variable "role_arn" {
  description = "ARN del rol IAM."
  type        = string
}
variable "instance_types" {
  description = "Lista de tipos de instancia EC2 para el node group"
  type        = list(string)
  default     = ["t2.micro"]
}

variable "capacity_type" {
  description = "Tipo de capacidad para las instancias EC2. Valores: ON_DEMAND, SPOT"
  type        = string
  default     = "SPOT"
}

#Permite crear rutas de api gateway. También indica que no tiene que re construir los S3.
variable "create_routes" {
  default = false
}
