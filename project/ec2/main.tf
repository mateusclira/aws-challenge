data "aws_availability_zones" "available" {}

resource "ec2_instance" "ec1" {
  name = var.ec1

  ami                         = "ami-022c9f1a24f813bf9"
  instance_type               = "t3.micro" # used to set core count below
  availability_zone           = "us-west-2a"
  subnet_id                   = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids      = var.default_security_group_id
  placement_group             = aws_placement_group.web.id
  associate_public_ip_address = true
  disable_api_stop            = false

  create_iam_instance_profile = true

  iam_role_description = "IAM role for EC2 instance"

  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}

resource "ec2_instance" "ec2" {
  name = var.ec2

  ami                         = "ami-022c9f1a24f813bf9"
  instance_type               = "t3.micro" # used to set core count below
  availability_zone           = "us-west-2a"
  subnet_id                   = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids      = var.default_security_group_id
  placement_group             = aws_placement_group.web.id
  associate_public_ip_address = true
  disable_api_stop            = false

  create_iam_instance_profile = true

  iam_role_description = "IAM role for EC2 instance"

  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}
