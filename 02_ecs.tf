
# # ECS Cluster setup in the private subnet
# resource "aws_kms_key" "ecs" {
#   description             = "${var.project_name}-${var.environment}-key"
#   deletion_window_in_days = 7
# }

# resource "aws_cloudwatch_log_group" "ecs" {
#   name = "${var.project_name}-${var.environment}-lg"
# }

# resource "aws_ecs_cluster" "main" {
#   name = "${var.project_name}-${var.environment}-ecs"

#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }

#   configuration {
#     execute_command_configuration {
#       kms_key_id = aws_kms_key.ecs.arn
#       logging    = "OVERRIDE"

#       log_configuration {
#         cloud_watch_encryption_enabled = true
#         cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs.name
#       }
#     }
#   }

# }

# resource "aws_ecs_cluster_capacity_providers" "main" {
#   cluster_name = aws_ecs_cluster.main.name

#   capacity_providers = ["FARGATE"]

#   default_capacity_provider_strategy {
#     base              = 1
#     weight            = 100
#     capacity_provider = "FARGATE"
#   }
# }

# # Target Group for the ECS Tasks
# resource "aws_lb_target_group" "ecs_target_group" {
#   name     = "${var.project_name}-${var.environment}-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id
#   health_check {
#     enabled = true
#     path    = "/"
#     protocol = "HTTP"
#     matcher = "200"
#   }
# }

# # Listener for the ALB, forwarding requests to the target group
# resource "aws_lb_listener" "front_end" {
#   load_balancer_arn = aws_lb.public_alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.ecs_target_group.arn
#   }
# }

# # ECS Task Definition
# resource "aws_ecs_task_definition" "ecs_task" {
#   family                   = "service"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = "256"
#   memory                   = "512"
#   execution_role_arn       = aws_iam_role.ecs_execution_role.arn
#   container_definitions    = <<EOF
# [
#   {
#     "name": "my-app",
#     "image": "my-app-image",
#     "essential": true,
#     "portMappings": [
#       {
#         "containerPort": 80,
#         "hostPort": 80
#       }
#     ]
#   }
# ]
# EOF
# }

# # ECS Service with integrated ALB setup
# resource "aws_ecs_service" "ecs_service" {
#   name            = "${var.project_name}-${var.environment}-service"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.ecs_task.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets          = [aws_subnet.private_subnet.id]
#     security_groups  = [aws_security_group.ecs_tasks_sg.id]
#     assign_public_ip = false
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.ecs_target_group.arn
#     container_name   = "my-app"
#     container_port   = 80
#   }

#   depends_on = [
#     aws_lb_listener.front_end,
#   ]
# }
