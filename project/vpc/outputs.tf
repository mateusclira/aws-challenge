output "vpc_id" {
    value = aws_vpc.main.id
}

output "aws_subnet" {
    value = [aws_subnet.public.id, aws_subnet.public2.id]
}

output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}
