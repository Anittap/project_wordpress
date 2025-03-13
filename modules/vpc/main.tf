resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, var.bits, count.index)
  availability_zone       = data.aws_availability_zones.virginia.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.project_environment}-public${count.index + 1}"
    Type = "public"
  }
}
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.bits, count.index + 3)
  availability_zone = data.aws_availability_zones.virginia.names[count.index +3]


  tags = {
    Name = "${var.project_name}-${var.project_environment}-private${count.index + 1}"
    Type = "private"
  }
}
