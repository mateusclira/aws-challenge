output "lb_dns_name" {
  value = module.alb.lb_dns_name
}
output "ec2_1_id" {
  value = module.ec2.ec2_1_id
}
output "ec2_2_id" {
  value = module.ec2.ec2_2_id
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "aws_subnet_public" {
  value = module.vpc.aws_subnet_public
}
output "aws_subnet_private" {
  value = module.vpc.aws_subnet_private
}
