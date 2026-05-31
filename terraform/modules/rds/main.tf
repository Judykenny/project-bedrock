resource "aws_db_subnet_group" "main" {
  name       = "project-bedrock-db-subnet"
  subnet_ids = var.private_subnet_ids
  tags       = { Name = "project-bedrock-db-subnet" }
}

resource "aws_security_group" "rds" {
  name   = "project-bedrock-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "project-bedrock-rds-sg" }
}

resource "aws_db_instance" "mysql" {
  identifier        = "project-bedrock-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = "retailstore"
  username          = "dbadmin"
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
  multi_az               = false
  publicly_accessible    = false

  tags = { Name = "project-bedrock-mysql" }
}

resource "aws_db_instance" "postgres" {
  identifier        = "project-bedrock-postgres"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = "retailstore"
  username          = "dbadmin"
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
  multi_az               = false
  publicly_accessible    = false

  tags = { Name = "project-bedrock-postgres" }
}
