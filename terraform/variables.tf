# Archivo de variables
# Pasar valores de variables al llamar el comando.
# Ej: terraform apply -var="region=us-east-1" -var="app_name=orders"
# Ej: terraform apply -var-file="develop.tfvars"
# Se pueden combinar. Ej: terraform apply -var-file="develop.tfvars" -var="app_name=orders"

variable "environment" {
  description = "Nombre del entorno. Valores: develop, staging, production."
  type        = string
}

variable "role_arn" {
  description = "ARN del rol IAM."
  type        = string
}

variable "app_name" {
  description = "Nombre de la app. Valores: orders, products, shipping y payments"
  type        = string
}

