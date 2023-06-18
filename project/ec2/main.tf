data "aws_availability_zones" "available" {}
data "aws_iam_instance_profile" "iam_role" {
  name = "admin"
}

resource "aws_instance" "instance1" {

  ami                         = "ami-022c9f1a24f813bf9"
  instance_type               = "t3.micro" # used to set core count below
  availability_zone           = "us-west-2a"
  subnet_id                   = var.aws_subnet[0]
  vpc_security_group_ids      = var.default_security_group_id
  associate_public_ip_address = true
  disable_api_stop            = false

  aws_iam_instance_profile = data.aws_iam_role.iam_role.name

  iam_role_description = "IAM role for EC2 instance"

  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}

resource "aws_instance" "instance2" {

  ami                         = "ami-022c9f1a24f813bf9"
  instance_type               = "t3.micro" # used to set core count below
  availability_zone           = "us-west-2a"
  subnet_id                   = var.aws_subnet[1]
  vpc_security_group_ids      = var.default_security_group_id
  associate_public_ip_address = true
  disable_api_stop            = false

  iam_instance_profile = data.aws_iam_role.iam_role.name

  iam_role_description = "IAM role for EC2 instance"

  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}
