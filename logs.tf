resource "aws_cloudwatch_log_group" "checkin-backend-log-group" {
  name              = "/ecs/checkin-backend"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "checkin-backend-log-stream" {
  name           = "checkin-backend-log-stream"
  log_group_name = aws_cloudwatch_log_group.checkin-backend-log-group.name
}

resource "aws_cloudwatch_log_group" "checkin-frontend-log-group" {
  name              = "/ecs/checkin-frontend"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "checkin-frontend-log-stream" {
  name           = "checkin-frontend-log-stream"
  log_group_name = aws_cloudwatch_log_group.checkin-frontend-log-group.name
}
