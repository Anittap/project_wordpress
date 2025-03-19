resource "aws_lb_target_group" "tg" {
  name                          = "${var.project_name}-${var.project_environment}-${var.name}"
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  port                          = var.port
  protocol                      = var.protocol
  vpc_id                        = var.vpc_id
  deregistration_delay          = var.deregistration_delay
  stickiness    {
    type                = var.stickiness_type
    cookie_duration     = var.cookie_duration
  }
  health_check  {
    enabled             = var.health_check_enabled
    healthy_threshold   = var.healthy_threshold
    interval            = var.interval
    path                = var.path
    protocol            = var.health_check_protocol
    unhealthy_threshold = var. unhealthy_threshold
    matcher             = var.matcher
    timeout             = var.timeout
  }
}