resource "aws_lambda_function" "get-contact-lambda-new" {
  function_name = "contact-get-new"

  s3_bucket = var.s3_bucket
  s3_key    = "getLambda.zip"

  handler     = "index.handler"
  runtime     = "nodejs14.x"
  memory_size = 128

  role = aws_iam_role.lambda-iam-role.arn
}

resource "aws_lambda_permission" "api-gateway-invoke-get-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get-contact-lambda-new.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.contact-api-gateway-deployment-new.execution_arn}/*/*"
}

