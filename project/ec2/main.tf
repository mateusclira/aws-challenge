data "aws_availability_zones" "available" {}

resource "aws_instance" "instance1" {
  ami                         = "ami-022c9f1a24f813bf9"
  instance_type               = "t3.micro" # used to set core count below
  availability_zone           = "us-west-2a"
  subnet_id                   = var.aws_subnet_private[0]
  vpc_security_group_ids      = [var.ec2_sg]
  key_name                    = aws_key_pair.key.key_name

  user_data = data.template_file.userdata.rendered
}

resource "aws_instance" "instance2" {
  ami                         = "ami-022c9f1a24f813bf9"
  instance_type               = "t3.micro" # used to set core count below
  availability_zone           = "us-west-2b"
  subnet_id                   = var.aws_subnet_private[1]
  vpc_security_group_ids      = [var.ec2_sg]
  key_name                    = aws_key_pair.key.key_name

  user_data = data.template_file.userdata.rendered
  tags = {
    Name = "instance2"
  }
}

resource "aws_instance" "bastion" {
  ami                         = "ami-022c9f1a24f813bf9"
  instance_type               = "t3.micro" # used to set core count below
  availability_zone           = "us-west-2a"
  subnet_id                   = var.aws_subnet_public[0]
  vpc_security_group_ids      = [var.bastion_sg]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key.key_name
  tags = {
    Name = "Bastion"
   }
}

resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCdBw7Hjj66enkSa+aMBKRhDPVRBQ7GWgn6/OhUmHawJId0hapE1WimzeZ487EHooCAqPW6YnGRtAu8Yky3vwLsYczpDL1PqEOPn5WsCRPFWSf8e6Og8NdFdG7sCpGPF1svweHKoR8a7XQFqo3l8dyzJLAzemxrq92lFfUf2dyc8hfO1Y80ypoVwKWIcxq3+kayv/CGGIJ9llD7ZI5jhZZo6E2KLoP43q9ff9SAoV0MqK9wc3tvc7lyx6GiDacVv5HBYSBbdng7BAwkv3gea3B2cREteAzNrq9tGpKVHUtoRq2nv5Y6VTipXdxLu3iY6YhKWvQL3KK9khY0t+nNhP+5Kwaj70sc4IEdSnayp3xFBczFAe2T2KdSgBZgtxiefb6zs8e3Jr1aovuu7PlMwacQPTE2z5+u/EWGcjQNPDbrI0LaaXJlUC99udcsX1v9KUDObIbds1U4C6oQYwOqd/HJM3p0c4fO/vwxX/99631+MCxGW1XCRG/WijqYPHg3JXhUmAqKnKE10UQ08xYyDVKja2gL2cWyUtRdpGxplhLZAeWP01FIjJiuzM53x5TsryBxnT23Oj+WjNOBRwwR9nuL5Yd00ox2GaDjHilWU0JnKciwyVop9PP3gYvTilEQCFM5GLaf9m6kDn3swPU8FEL05QKe6s+CDlKDvqPjTNi5mw== mateusc.lira@gmail.com"
}

data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    DOCKERFILE_BASE64 = filebase64("${path.root}/Docker/Dockerfile")
    OKJPG_BASE64      = filebase64("${path.root}/Docker/ok.jpg")
    INDEX_HTML_BASE64 = filebase64("${path.root}/Docker/index.html")
    TEST_PHP_BASE64   = filebase64("${path.root}/Docker/test.php")
  }
}
