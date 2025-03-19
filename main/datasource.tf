data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}
data "aws_ami" "packer_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["${var.project_name}-${var.project_environment}-*"]
  }
}
data "aws_secretsmanager_secret" "db_credentials" {
  name = "wordpress-db-credentials"
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}
data "aws_instances" "wordpress_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [module.wp_asg.asg_name]
  }
}
