resource "aws_route_table" "main" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project_name}-${var.project_environment}-${var.type}"
  }
}
resource "aws_route_table_association" "main" {
  count          = 3
  subnet_id      = var.subnet_id[count.index]
  route_table_id = aws_route_table.main.id
}
resource "aws_route" "peering_route" {
  count = var.enable_peering ? 1 : 0

  route_table_id         = aws_route_table.main.id
  destination_cidr_block = var.peer_cidr_block
  vpc_peering_connection_id = var.vpc_peering_connection_id
}

resource "aws_route" "internet_route" {
  count = var.enable_internet ? 1 : 0

  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}