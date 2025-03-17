resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}
resource "aws_db_instance" "database" {
  identifier             = var.db_name
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  username             = var.db_username
  password             = var.db_password
  publicly_accessible   = false 
  db_subnet_group_name  = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.sg_id]
  multi_az             = false
  skip_final_snapshot  = true
  db_name              = var.db_name
}
