resource "aws_api_gateway_rest_api" "default" {
  count = var.apigateway_invoke ? 1 : 0

  name        = var.name
  description = "Rest API for ${var.name}"
}

resource "aws_api_gateway_resource" "default" {
  count = var.apigateway_invoke ? 1 : 0

  rest_api_id = aws_api_gateway_rest_api.default[count.index].id
  parent_id   = aws_api_gateway_rest_api.default[count.index].root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "default" {
  count = var.apigateway_invoke ? 1 : 0

  rest_api_id   = aws_api_gateway_rest_api.default[count.index].id
  resource_id   = aws_api_gateway_resource.default[count.index].id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "default" {
  count = var.apigateway_invoke ? 1 : 0

  rest_api_id = aws_api_gateway_rest_api.default[count.index].id
  resource_id = aws_api_gateway_method.default[count.index].resource_id
  http_method = aws_api_gateway_method.default[count.index].http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.default.invoke_arn
}

resource "aws_api_gateway_deployment" "default" {
  count = var.apigateway_invoke ? 1 : 0

  depends_on = [aws_api_gateway_integration.default]

  rest_api_id = aws_api_gateway_rest_api.default[count.index].id
  stage_name  = var.name
}

resource "aws_lambda_permission" "grant_invoke" {
  count = var.apigateway_invoke ? 1 : 0

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.default[count.index].execution_arn}/*/*"
}
