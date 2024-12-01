variable "environment" {
  description = "Nombre del entorno. Valores: develop, staging, production."
  type        = string
}

variable "index_document" {
  description = "Nombre del documento principal del sitio"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Nombre del documento de error del sitio"
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "Etiquetas para el bucket S3"
  type        = map(string)
  default     = {}
}
