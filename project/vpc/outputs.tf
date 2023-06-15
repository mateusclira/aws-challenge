output "vpc_id" {
    value = aws_vpc.main.id
}

output "aws_subnet" {
    value = [aws_subnet.public.id, aws_subnet.public2.id]
}

output "default_security_group_id" {
  value = try(aws_vpc.this[0].default_security_group_id, null)
}
