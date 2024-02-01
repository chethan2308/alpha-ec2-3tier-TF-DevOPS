resource "aws_lb" "alpha_alb" {
  name               = "alpha-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet_AZ1.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet_AZ2.id
  }

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "alpha-target-resource" {

  name        = "alpha-target-check"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.alpha-vpc.id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200,301,302"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2

  }
}

resource "aws_lb_listener" "alpha-listener" {
  load_balancer_arn = aws_lb.alpha_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"


    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}

resource "aws_lb_listener" "alpha_https" {
  load_balancer_arn = aws_lb.alpha_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl-cert

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alpha-target-resource.arn
  }
}

