#Este archivo usa count. Para saber si tiene que crear 0 o 1 cantidad de objetos. 
#Este valor se lee del parámetro var.create_routes. Si es true, crea 1, si es false, crea 0.
#Permite no crear la API Gateway si estoy haciendo el spin up inicial. 
#Porque hay que esperar a que se haga un deploy inicial de un entorno para que estén disponibles los services de kubernetes.

locals {
  products_url = file("${path.module}/options-${var.environment}/service-url-products.txt")
  orders_url   = file("${path.module}/options-${var.environment}/service-url-orders.txt")
  payments_url = file("${path.module}/options-${var.environment}/service-url-payments.txt")
  shipping_url = file("${path.module}/options-${var.environment}/service-url-shipping.txt")
}

# API Gateway tipo HTTP API
resource "aws_apigatewayv2_api" "gateway_obligatorio" {
  count         = var.create_routes ? 1 : 0
  name          = "api-obligatorio_${var.environment}"
  protocol_type = "HTTP"
}

# Products
resource "aws_apigatewayv2_integration" "products_integration" {
  count                  = var.create_routes ? 1 : 0
  api_id                 = aws_apigatewayv2_api.gateway_obligatorio[0].id
  integration_type       = "HTTP_PROXY"
  integration_uri        = join("", [local.products_url, "/products"])
  payload_format_version = "1.0"
  integration_method     = "GET"
}

resource "aws_apigatewayv2_integration" "products_integration_2" {
  count                  = var.create_routes ? 1 : 0
  api_id                 = aws_apigatewayv2_api.gateway_obligatorio[0].id
  integration_type       = "HTTP_PROXY"
  integration_uri        = join("", [local.products_url, "/products/{id}"])
  payload_format_version = "1.0"
  integration_method     = "GET"
}

resource "aws_apigatewayv2_route" "get_products_route" {
  count     = var.create_routes ? 1 : 0
  api_id    = aws_apigatewayv2_api.gateway_obligatorio[0].id
  route_key = "GET /products"

  target = "integrations/${aws_apigatewayv2_integration.products_integration[count.index].id}"
}
resource "aws_apigatewayv2_route" "get_products_route_2" {
  count     = var.create_routes ? 1 : 0
  api_id    = aws_apigatewayv2_api.gateway_obligatorio[0].id
  route_key = "GET /products/{id}"

  target = "integrations/${aws_apigatewayv2_integration.products_integration_2[count.index].id}"
}

# Orders
resource "aws_apigatewayv2_integration" "orders_integration" {
  count                  = var.create_routes ? 1 : 0
  api_id                 = aws_apigatewayv2_api.gateway_obligatorio[0].id
  integration_type       = "HTTP_PROXY"
  integration_uri        = join("", [local.orders_url, "/orders"])
  payload_format_version = "1.0"
  integration_method     = "POST"
}



resource "aws_apigatewayv2_route" "get_orders_route" {
  count     = var.create_routes ? 1 : 0
  api_id    = aws_apigatewayv2_api.gateway_obligatorio[0].id
  route_key = "POST /orders"

  target = "integrations/${aws_apigatewayv2_integration.orders_integration[count.index].id}"

}

#Payments
resource "aws_apigatewayv2_integration" "payments_integration" {
  count                  = var.create_routes ? 1 : 0
  api_id                 = aws_apigatewayv2_api.gateway_obligatorio[0].id
  integration_type       = "HTTP_PROXY"
  integration_uri        = join("", [local.payments_url, "/payments/{id}"])
  payload_format_version = "1.0"
  integration_method     = "POST"
}

resource "aws_apigatewayv2_route" "get_payments_route" {
  count     = var.create_routes ? 1 : 0
  api_id    = aws_apigatewayv2_api.gateway_obligatorio[0].id
  route_key = "POST /payments/{id}"

  target = "integrations/${aws_apigatewayv2_integration.payments_integration[count.index].id}"
}

#Shipping
resource "aws_apigatewayv2_integration" "shipping_integration" {
  count                  = var.create_routes ? 1 : 0
  api_id                 = aws_apigatewayv2_api.gateway_obligatorio[0].id
  integration_type       = "HTTP_PROXY"
  integration_uri        = join("", [local.shipping_url, "/shipping/{id}"])
  payload_format_version = "1.0"
  integration_method     = "GET"
}

resource "aws_apigatewayv2_route" "get_shipping_route" {
  count     = var.create_routes ? 1 : 0
  api_id    = aws_apigatewayv2_api.gateway_obligatorio[0].id
  route_key = "GET /shipping/{id}"

  target = "integrations/${aws_apigatewayv2_integration.shipping_integration[count.index].id}"
}

# Stage
resource "aws_apigatewayv2_stage" "current_stage" {
  count  = var.create_routes ? 1 : 0
  api_id = aws_apigatewayv2_api.gateway_obligatorio[0].id
  name   = "${var.environment}"

  deployment_id = aws_apigatewayv2_deployment.deploy_inicial[count.index].id #Accede a la primer instancia. Si crea una, count.index vale 0. So no se crea una instancia, entonces no se lee el valor porque no se entra a esta línea.

  auto_deploy = true
}

# Deploy
resource "aws_apigatewayv2_deployment" "deploy_inicial" {
  count  = var.create_routes ? 1 : 0
  api_id = aws_apigatewayv2_api.gateway_obligatorio[0].id
}
