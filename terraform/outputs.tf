#Archivo con variables de salida.
#Se pueden leer los valores de varias formas.
#Generando un archivo por variable de salida:
#   terraform output -raw ecr_repository_uri > ecr_repository_uri.txt
#Generando un archivo json:
#   terraform output -json > outputs.json

output "ecr_repository_uri_orders" {
  value       = aws_ecr_repository.ecr_obligatorio_orders.repository_url
  description = "La URI del repositorio de orders"
  depends_on  = [aws_ecr_repository.ecr_obligatorio_orders]
}

output "ecr_repository_uri_shipping" {
  value       = aws_ecr_repository.ecr_obligatorio_shipping.repository_url
  description = "La URI del repositorio de shipping"
  depends_on  = [aws_ecr_repository.ecr_obligatorio_shipping]
}

output "ecr_repository_uri_payments" {
  value       = aws_ecr_repository.ecr_obligatorio_payments.repository_url
  description = "La URI del repositorio de payments"
  depends_on  = [aws_ecr_repository.ecr_obligatorio_payments]
}

output "ecr_repository_uri_products" {
  value       = aws_ecr_repository.ecr_obligatorio_products.repository_url
  description = "La URI del repositorio de products"
  depends_on  = [aws_ecr_repository.ecr_obligatorio_products]
}

output "http_api_obligatorio_url" {
  value       = aws_apigatewayv2_api.http_api_obligatorio.api_endpoint
  description = "Base URL of the HTTP API Gateway"
}

output "bucket_name" {
  value = module.static_site.bucket_name
}