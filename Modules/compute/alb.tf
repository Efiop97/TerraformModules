# Check if there is only one subnet
locals {
  is_single_subnet = length(var.subnet_id) == 1
}

# Define a condition to control resource creation based on the number of subnets
resource "aws_lb" "alb" {
  count              = local.is_single_subnet ? 0 : 1
  name               = "Igor-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_id
  security_groups    = [aws_security_group.sec_group.id]

  tags = {
    Name = "Igor-alb"
  }
}

resource "aws_lb_target_group" "lb_tg" {
  count = local.is_single_subnet ? 0 : 1
  name     = "igors-lb-tg"
  port     = var.Port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "listener" {
  count              = local.is_single_subnet ? 0 : 1
  load_balancer_arn = aws_lb.alb[0].arn
  port              = var.Port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg[0].arn
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment_1" {
  count            = local.is_single_subnet ? 0 : var.instanceCount
  target_group_arn = aws_lb_target_group.lb_tg[0].arn
  target_id        = aws_instance.ec2[count.index].id
  port             = var.Port
}
