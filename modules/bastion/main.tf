resource "aws_instance" "bastion" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name      = var.key_name
    subnet_id     = var.public_subnet_id
    vpc_security_group_ids = [var.security_group_id]
    tags = {
        Name = "${var.project_name}-${var.project_environment}-bastion"
    }
    }