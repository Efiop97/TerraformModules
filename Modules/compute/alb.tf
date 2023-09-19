resource "aws_lb" "igor_alb" {
  name               = "Igor-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_id[*]
  security_groups    = [aws_security_group.igor-sg-terra.id]

  tags = {
    Name = "Igor-alb"
  }
}

resource "aws_lb_target_group" "Igor-lb-tg" {
  name     = "Igor-lb-tg"
  port     = var.Port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "igor_listener" {
  load_balancer_arn = aws_lb.igor_alb.arn
  port              = var.Port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Igor-lb-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment_1" {
  count            = var.instanceCount
  target_group_arn = aws_lb_target_group.Igor-lb-tg.arn
  target_id        = aws_instance.igor-Easy[count.index].id
  port             = var.Port
}
