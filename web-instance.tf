#create ec2 instance
resource "aws_security_group" "aws_security_group1" {
  name = "raghda_securitygroup_1"
  description="allowing http and https inbound traffic"

  vpc_id =data.aws_vpc.vpc.id
  ingress {
    description = "Https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags={
    Name="allow_http_https"
  }

}
resource "aws_instance" "web_instance" {
  ami           = "ami-0c0933ae5caf0f5f9"
  instance_type = "t2.micro"


  vpc_security_group_ids = [aws_security_group.aws_security_group1.id]

  subnet_id =  aws_subnet.creating-subnets["public_subnet"].id


  key_name = "raghda_keypair"
  

  tags = {
    Name = "raghda_web_instance"
  }
}


resource  "aws_eip" "elasticIp"{
    instance = aws_instance.web_instance.id
    vpc = true
    
}

 
terraform {
    backend "s3" {
    bucket = "raghda-terraform-s3-bucket"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}