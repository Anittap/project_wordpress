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