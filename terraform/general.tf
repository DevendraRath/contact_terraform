provider "aws" {
  region = "us-east-2"
}

variable "lambda_version"     { default = "1.0.0"}
variable "s3_bucket"          { default = "contact-bucket2022"}