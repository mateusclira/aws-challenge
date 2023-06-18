resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "wiley-vpc"
    }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.9.0/24"
  availability_zone = "us-west-2b"
}
resource "aws_security_group" "main" {
  name        = "CustomSG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.public_ip}/32"] 
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${var.alb_sg_id}"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
