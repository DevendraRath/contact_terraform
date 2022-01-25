provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAUX7MCFTWF3UELJTT"
  secret_key = "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"
}

data "archive_file" "getLambda" {
  type        = "zip"
  source_file = "${path.module}/../get/index.js"
  output_path = "${path.module}/myFiles/getLambda.zip"
}

data "archive_file" "postLambda" {
  type        = "zip"
  source_file = "${path.module}/../post/index.js"
  output_path = "${path.module}/myFiles/postLambda.zip"
}

resource "aws_s3_bucket" "contact-bucket2022-new" {
   bucket = "contact-bucket2022-new"
   acl = "private"  
}

resource "aws_s3_bucket_object" "contact-bucket2022_object" {
  for_each = fileset("myfiles/", "*")
  bucket = aws_s3_bucket.contact-bucket2022-new.id
  key = each.value
  source = "myfiles/${each.value}"
}

# variable "lambda_version" { default = "1.0.0" }
variable "s3_bucket" { default = "contact-bucket2022-new" }
