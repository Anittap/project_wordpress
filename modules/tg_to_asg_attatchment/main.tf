resource "aws_autoscaling_attachment" "main" {
  lb_target_group_arn    = var.tg_arn
  autoscaling_group_name = var.asg_id
}