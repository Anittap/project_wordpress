resource "aws_launch_template" "lt" {
  name                   = "${var.project_name}-${var.project_environment}-${var.name}"
  image_id               = var.ami_id
  key_name               = var.key_pair
  vpc_security_group_ids = [var.sg_id]
  description            = "Launch template for asg"

  tags = {
    Name        = "${var.project_name}-${var.project_environment}-${var.name}"
  }
  lifecycle {
    create_before_destroy = true
  }
}