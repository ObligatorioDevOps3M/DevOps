#Archivo con variables de salida.
#Se pueden leer los valores de varias formas.
#Generando un archivo por variable de salida:
#   terraform output -raw ecr_repository_uri > ecr_repository_uri.txt
#Generando un archivo json:
#   terraform output -json > outputs.json

output "ecr_repository_uri" {
  value       = aws_ecr_repository.ecr_obligatorio.repository_url
  description = "La URI del repositorio ECR creado"
  depends_on = [ aws_ecr_repository.ecr_obligatorio ]
}