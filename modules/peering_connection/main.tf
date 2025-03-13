resource "aws_vpc_peering_connection" "main" {
  peer_vpc_id = var.accepter_id
  vpc_id      = var.requester_id
  auto_accept = true

  tags = {
    Name = "${var.project_name}-${var.project_environment}-peering-connection"
  }
}
