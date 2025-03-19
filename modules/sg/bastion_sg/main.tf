resource "aws_vpc_security_group_ingress_rule" "bastion" {
  for_each                 = toset(var.sg_ports)
  from_port                = each.key
  to_port                  = each.key
  ip_protocol                 = "tcp"
  security_group_id        = var.sg_id
  referenced_security_group_id = var.referenced_security_group_id
  description              = "Allow SSH access from Bastion to WP instances"
}