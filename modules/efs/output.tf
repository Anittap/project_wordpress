output "efs_dns_name" {
    description = "The ID of the EFS file system"
    value       = aws_efs_file_system.efs.dns_name
}