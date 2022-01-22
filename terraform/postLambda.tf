resource "aws_lambda_function" "post-contacts-lambda" {
  function_name = "contact-post"

  s3_bucket = var.s3_bucket
  s3_key    = "v${var.lambda_version}/postLambda.zip"

  handler     = "index.handler"
  runtime     = "nodejs14.x"
  memory_size = 128

  role = aws_iam_role.lambda-iam-role.arn
}

resource "aws_lambda_permission" "api-gateway-invoke-post-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.post-contacts-lambda.arn
  principal     = "apigateway.amazonaws.com"


  source_arn = "${aws_api_gateway_deployment.contact-api-gateway-deployment.execution_arn}/*/*"
}



