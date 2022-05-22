resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_imagebuilder_infrastructure_configuration" "this" {
  description                   = "Simple infrastructure configuration"
  instance_profile_name         = aws_iam_instance_profile.ec2.name
  instance_types                = ["t2.micro"]
  name                          = "amazon-windows-infr"
  security_group_ids            = [aws_security_group.allow_tls.id]
  subnet_id                     = aws_subnet.main.id
  terminate_instance_on_failure = true

  tags = {
    Name = "amazon-windows-infr"
  }
}
