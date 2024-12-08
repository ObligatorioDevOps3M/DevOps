locals {
  products_url = file("${path.module}/options-${var.environment}/service-url-products.txt")
}

# API Gateway tipo HTTP API
resource "aws_apigatewayv2_api" "gateway_obligatorio" {
  count         = var.create_routes ? 1 : 0
  name          = "api-obligatorio"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "products_integration" {
  count                  = var.create_routes ? 1 : 0
  api_id                 = aws_apigatewayv2_api.gateway_obligatorio[0].id
  integration_type       = "HTTP_PROXY"
  integration_uri        = local.products_url
  payload_format_version = "1.0"
  integration_method     = "GET"
}

resource "aws_apigatewayv2_route" "get_products_route" {
  count     = var.create_routes ? 1 : 0
  api_id    = aws_apigatewayv2_api.gateway_obligatorio[0].id
  route_key = "GET /products"

  target = "integrations/${aws_apigatewayv2_integration.products_integration[0].id}"
}

resource "aws_apigatewayv2_stage" "develop" {
  api_id = aws_apigatewayv2_api.gateway_obligatorio[0].id
  name   = "develop"
  
  deployment_id = aws_apigatewayv2_deployment.deploy_inicial.id
  
  auto_deploy = true

  depends_on = [ aws_apigatewayv2_route.get_products_route ]
}

resource "aws_apigatewayv2_deployment" "deploy_inicial" {
  api_id = aws_apigatewayv2_api.gateway_obligatorio[0].id
}