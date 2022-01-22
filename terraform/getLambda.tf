resource "aws_lambda_function" "get-contact-lambda" {
  function_name = "contact-get"

  s3_bucket = var.s3_bucket
  s3_key    = "v${var.lambda_version}/getLambda.zip"

  handler     = "index.handler"
  runtime     = "nodejs14.x"
  memory_size = 128

  role = aws_iam_role.lambda-iam-role.arn
}

resource "aws_lambda_permission" "api-gateway-invoke-get-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get-contact-lambda.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.contact-api-gateway-deployment.execution_arn}/*/*"
}

