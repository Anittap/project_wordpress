output "public_ip" {
    description = "The public IP address of the bastion host"
    value       = aws_instance.bastion.public_ip
}