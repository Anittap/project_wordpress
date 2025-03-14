resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-${var.name}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each          = toset(var.sg_ports)
  security_group_id = aws_security_group.main.id
  referenced_security_group_id  = var.sg_reference_id
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}-${var.name}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         =  var.egress_cidr_ipv4
  ip_protocol       = var.egress_port
  tags = {
    Name = "${var.project_name}-${var.project_environment}-${var.name}"
  }
}