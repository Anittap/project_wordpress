resource "aws_eip" "main" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
  depends_on = [aws_eip.main]
}