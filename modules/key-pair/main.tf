resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = var.key_file
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}