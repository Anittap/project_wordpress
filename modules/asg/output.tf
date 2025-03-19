output "id" {
    description = "The ID of the Auto Scaling Group"
    value       = aws_autoscaling_group.main.id
}
output "asg_name" {
  value = aws_autoscaling_group.main.name
}
