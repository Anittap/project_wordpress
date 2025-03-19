output "dns_name" {
    description = "The DNS name of the ALB"
    value       = aws_lb.main.dns_name
}

output "zone_id" {
    description = "The Zone name of the ALB"
    value       = aws_lb.main.zone_id
}