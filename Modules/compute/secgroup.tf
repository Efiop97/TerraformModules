resource "aws_security_group" "igor-sg-terra" {
  name        = "igor-sg-terra"
  description = "igor-sg-terra"
  vpc_id      = var.vpc_id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allTraffic]
  }

  ingress {
    from_port   = var.Port
    to_port     = var.Port
    protocol    = "tcp"
    cidr_blocks = [var.allTraffic]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allTraffic]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allTraffic]
  }
}