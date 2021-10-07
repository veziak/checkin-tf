resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

data "template_file" "task_definition_template" {
  template = file("templates/checkin.json.tpl")

  vars = {
    frontend_image_url = var.frontend_image_url
    backend_image_url  = var.backend_image_url
    region             = var.region
  }
}

resource "aws_ecs_task_definition" "checkin_app_task_definition" {
  family                   = "checkin-app"
  container_definitions    = data.template_file.task_definition_template.rendered
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.checkin_app_task_definition.arn
  launch_type     = "FARGATE"
  depends_on      = [aws_alb_listener.ecs_alb_http_listener]

  network_configuration {
    subnets         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_groups = [aws_security_group.ecs_secuirity_group.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.default_target_group.arn
    container_name   = "checkin-frontend"
    container_port   = 8080
  }
}
