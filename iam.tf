resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs_task_execution_role"
  assume_role_policy = file("policies/ecs-task-execution-role.json")
}

resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name   = "ecs_task_execution_role_policy"
  policy = file("policies/ecs-task-execution-role-policy.json")
  role   = aws_iam_role.ecs_task_execution_role.id
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "ecs_task_role"
  assume_role_policy = file("policies/ecs-task-role.json")
}

resource "aws_iam_role_policy" "ecs_task_role_policy" {
  name   = "ecs_task_role_policy"
  policy = file("policies/ecs-task-role-policy.json")
  role   = aws_iam_role.ecs_task_role.id
}