resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-${var.name}"
  }
}