resource "aws_lb" "main" {
  name               = "wiley-alb"
  load_balancer_type = "application"

  subnets = [var.aws_subnet[0], var.aws_subnet[1]]
  security_groups = [var.default_security_group_id]
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_target_group" "main" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
