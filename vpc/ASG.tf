resource "aws_launch_template" "alpha-launch" {
  name          = "alpha-asg"
  image_id      = "ami-0e9107ed11be76fde"
  instance_type = "t2.micro"
  key_name      = "ec2-key"
  description   = "launch_template"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.webserver_security_group.id]

}

resource "aws_autoscaling_group" "alpha-asg" {
  vpc_zone_identifier = [aws_subnet.private_app_subnet_AZ1.id, aws_subnet.private_app_subnet_AZ2.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  name                = "dev-asg"
  health_check_type   = "ELB"

  launch_template {
    name    = aws_launch_template.alpha-launch.name
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "asg-webserver"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [target_group_arns]
  }
}

resource "aws_autoscaling_attachment" "alpha-asg-alb-attach" {
  autoscaling_group_name = aws_autoscaling_group.alpha-asg.id
  lb_target_group_arn    = aws_lb_target_group.alpha-target-resource.arn
}