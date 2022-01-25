resource "aws_lambda_function" "post-contacts-lambda-new" {
  function_name = "contact-post-new"

  s3_bucket = var.s3_bucket
  s3_key    = "postLambda.zip"

  handler     = "index.handler"
  runtime     = "nodejs14.x"
  memory_size = 256

  role = aws_iam_role.lambda-iam-role.arn
}

resource "aws_lambda_permission" "api-gateway-invoke-post-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.post-contacts-lambda-new.arn
  principal     = "apigateway.amazonaws.com"


  source_arn = "${aws_api_gateway_deployment.contact-api-gateway-deployment-new.execution_arn}/*/*"
}



