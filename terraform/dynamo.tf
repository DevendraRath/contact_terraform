resource "aws_dynamodb_table" "contact-dynamodb-table" {
  name           = "contact_table"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "contact_id"

  attribute {
    name = "contact_id"
    type = "S"
  }
}

