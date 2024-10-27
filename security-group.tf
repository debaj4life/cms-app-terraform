#Creating a Security group
resource "aws_security_group" "cms_app_sg" {
  name        = "cms-app-sg-${var.environment}"
  description = "security group to allow ssh"
  vpc_id      = var.vpc_id
  tags = {
    Name = "cms-app-sg"
  }
}

#Create Ingress rule to allow ssh
resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  description       = "ssh access to the server"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cms_app_sg.id
}

#Create egress rule to allow ssh
resource "aws_security_group_rule" "egress_ssh" {
  type              = "egress"
  description       = "ssh access to the server"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cms_app_sg.id
}

#Create Ingress rule to allow TCP
resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  description       = "http access to the server"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cms_app_sg.id
}

#Create Ingress rule to allow https
resource "aws_security_group_rule" "ingress_https" {
  type              = "ingress"
  description       = "https access to the server"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cms_app_sg.id
}

#Creating Security group for Network Load Balancer
resource "aws_security_group" "cms_app_lb_sg" {
  name        = "cms-app-lb-sg-${var.environment}"
  description = "security group to allow http"
  vpc_id      = var.vpc_id
  tags = {
    Name = "cms-app-lb-sg"
  }
}


#Create egress rule for the LB to allow http
resource "aws_security_group_rule" "egress_lb" {
  type              = "egress"
  description       = "http access to the server"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cms_app_lb_sg.id
}


#Create Ingress rule for the LB to allow http port 8081
resource "aws_security_group_rule" "lb_ingress_http" {
  type              = "ingress"
  description       = "http access to the server"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cms_app_lb_sg.id
}

#Create Ingress rule for the LB to allow https port 443
resource "aws_security_group_rule" "lb_ingress_https" {
  type              = "ingress"
  description       = "https access to the server"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cms_app_lb_sg.id
}



