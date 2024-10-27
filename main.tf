# Launch Template
resource "aws_launch_template" "cms_app_template" {
  name = "cms-app-lt-${var.environment}"
  image_id = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name

  network_interfaces {
    security_groups = [aws_security_group.cms_app_sg.id]
  }

  
  }

# Creating Auto Scaling Group
resource "aws_autoscaling_group" "cms_app_asg" {
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  name = "cms-app-asg-${var.environment}"
  target_group_arns = [ aws_lb_target_group.cms_app_tg.arn]
  vpc_zone_identifier = var.subnets

  tag {
    key                 = "Name"
    value               = "cms-app-${var.environment}"
    propagate_at_launch = true
  }
  

  launch_template {
    id      = aws_launch_template.cms_app_template.id
    version = "$Latest"
    
  }


  health_check_type = "EC2"
}