#Create Network Load Balancer
resource "aws_lb" "cms_app_lb" {
  name               = "cms-app-lb-${var.environment}"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.cms_app_lb_sg.id]
  subnets            = var.subnets

}

#Create Target group for NLB
resource "aws_lb_target_group" "cms_app_tg" {
  name        = "cms-app-tg-${var.environment}"
  target_type = "instance"
  port        = 8081
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    protocol            = "TCP"
    port                = 8081
  }
}



#Create port 8081 listener for NLB
resource "aws_lb_listener" "cms_app_lb_listener" {
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cms_app_tg.arn
  }
  load_balancer_arn = aws_lb.cms_app_lb.arn
  port              = 8081
  protocol          = "TCP"
}

#Create port 443 listener for NLB
resource "aws_lb_listener" "cms_app_nlb_listener" {
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cms_app_tg.arn
  }
  load_balancer_arn = aws_lb.cms_app_lb.arn
  port              = 443
  protocol          = "TLS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn =  aws_acm_certificate.cms_acm_certificate.arn

}

# Attach the certificate to the nlb listener
resource "aws_lb_listener_certificate" "cms_listener_certificate" {
  listener_arn = aws_lb_listener.cms_app_nlb_listener.arn
  certificate_arn = aws_acm_certificate.cms_acm_certificate.arn
}

