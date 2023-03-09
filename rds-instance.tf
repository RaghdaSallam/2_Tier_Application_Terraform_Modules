resource "aws_security_group" "aws_security_group2" {
  name        = "raghda_securitygroup_2"
  description = "allowing RDS traffic"

  vpc_id = data.aws_vpc.vpc.id
   

  ingress {
    description      = "RDS"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]

  }
  


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  tags = {
    Name = "allow_RDS"
  }
}

resource "aws_db_subnet_group" "sub_group" {
  name       = "raghda_sub_group"
  subnet_ids = [aws_subnet.creating-subnets["private_subnet_1"].id, aws_subnet.creating-subnets["private_subnet_2"].id]

  tags = {
    Name = "raghda_subnet_group"
  }
}


resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "Raghda_Database"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "raghda"
  password             = "1999raghda"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = "raghda_sub_group"
  multi_az = true

  port = 3306
  vpc_security_group_ids = [aws_security_group.aws_security_group2.id]
}
