resource "aws_db_subnet_group" "default" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}

resource "aws_db_instance" "default" {
  identifier              = var.db_name
  engine                  = var.db_engine
  instance_class          = var.instance_class
  allocated_storage       = 20
  db_name                 = var.db_name
  username                = "admin"
  password                = "StrongPass1234!" # Replace or externalize securely
  skip_final_snapshot     = true
  multi_az                = var.multi_az
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = var.vpc_security_ids

  tags = {
    Name = "${var.db_name}-instance"
  }
}

