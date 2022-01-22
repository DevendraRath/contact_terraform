resource "aws_api_gateway_rest_api" "contact-api-gateway" {
  name        = "contactAPI"
  description = "API to access codingtips application"
  body        = "${data.template_file.contact_api_swagger.rendered}"
}

data "template_file" contact_api_swagger{
  template = "${file("swagger.yaml")}"

  vars = {
    get_lambda_arn = "${aws_lambda_function.get-contact-lambda.invoke_arn}"
    post_lambda_arn = "${aws_lambda_function.post-contacts-lambda.invoke_arn}"
  }
}

resource "aws_api_gateway_deployment" "contact-api-gateway-deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.contact-api-gateway.id}"
  stage_name  = "default"
}

output "url" {
  value = "${aws_api_gateway_deployment.contact-api-gateway-deployment.invoke_url}/contacts"
}

