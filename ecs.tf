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
  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.checkin_app_task_definition.arn
  iam_role        = aws_iam_role.ecs_service_role.arn
  desired_count   = var.app_count
  launch_type     = "EC2"
  depends_on      = [aws_alb_listener.ecs_alb_http_listener, aws_iam_role_policy.ecs_service_role_policy]

  load_balancer {
    target_group_arn = aws_lb_target_group.default_target_group.arn
    container_name   = "checkin-frontend"
    container_port   = 8080
  }
}
