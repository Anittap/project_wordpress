output "db_username" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["username"]
  sensitive = true
}

output "db_password" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["password"]
  sensitive = true
}

output "db_name" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["database"]
  sensitive = true
}
output "rds_endpoint" {
  value = module.db_instance.address
}
output "wordpress_private_ips" {
  value = data.aws_instances.wordpress_instances.private_ips
}
output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "efs_id" {
  value = module.efs.efs_id
}
