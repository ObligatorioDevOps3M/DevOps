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