resource "aws_db_subnet_group" "rds" {
  name       = "${var.name_prefix}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-subnet-group"
  }
}

resource "aws_db_instance" "rds" {
  identifier              = "${var.name_prefix}-rds"
  engine                  = var.db_engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.storage
  storage_type            = var.storage_type
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = var.vpc_security_ids
  multi_az                = var.multi_az
  skip_final_snapshot     = true
  backup_retention_period = 7
  publicly_accessible     = false

  tags = {
    Name = "${var.name_prefix}-rds"
  }
}
