resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

resource "aws_dynamodb_table" "user_checkin_table" {
  name           = "UserCheckin"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Username"

  attribute {
    name = "Username"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
  }
}