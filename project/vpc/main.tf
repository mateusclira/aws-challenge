resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "wiley-vpc"
    }

}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.8.0/24"

  availability_zone = "us-west-2a"
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.9.0/24"

  availability_zone = "us-west-2b"
}
