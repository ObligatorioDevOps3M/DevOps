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
  value       = one(aws_apigatewayv2_api.gateway_obligatorio[*].api_endpoint)
  description = "Base URL of the HTTP API Gateway"
}

output "bucket_name" {
  value = one(module.static_site[*].bucket_name)
}

output "public-api-url" {
  value       = one(aws_apigatewayv2_stage.develop[*].invoke_url) #Se usa ONE porque esta var se llena si el flag de creación de API Gateway es true solamente.
  description = "URL de invocación para acceso público a la API"
}

