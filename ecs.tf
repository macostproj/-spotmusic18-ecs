resource "aws_ecs_cluster" "spotmusic_cluster" {
  name = "spotmusic-cluster"
}

resource "aws_ecs_task_definition" "spotmusic_task" {
  family                   = "spotmusic-task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.spotmusic_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "spotmusic"
      image     = "${aws_ecr_repository.spotmusic_repository.repository_url}:latest"
      cpu       = 256
      memory    = 512
      essential = true
    }
  ])
}
