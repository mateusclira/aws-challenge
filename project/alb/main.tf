resource "alb" "main" {    
  name               = "wiley-alb"
  load_balancer_type = "application"

  listener {
    instance_port = 22
    instance_protocol = "HTTP"
    lb_port = 80
    lb_protocol = "HTTP"
  }

  target_group {
    name             = "wiley-tg"
    backend_protocol = "HTTP"
    backend_port     = 80
    vpc_id           = var.vpc_id

    targets = {
        my_ec2_instance1 = {
            target_id = aws_instance.my_ec2_instance1.id
            port = 80
        },
        my_ec2_instance2 = {
            target_id = aws_instance.my_ec2_instance2.id
            port = 80
        },
        tags = {
            sysId = "6f1bb632-da38-4e1f-86c3-6065f8662f88"
        }
    }
  }

  subnets = [var.aws_subnet[0], var.aws_subnet[1]]

  security_groups = [var.default_security_group_id]

  security_group_rules = {
    ingress_all_http = {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "HTTP web traffic"
      cidr_blocks = ["187.21.2.183"]
    }
    ingress_all_icmp = {
      type        = "ingress"
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      description = "ICMP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
