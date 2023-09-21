resource "aws_security_group" "sec_group" {
  name        = "igor-sg-terra"
  description = "igor-sg-terra"
  vpc_id      = var.vpc_id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }

  ingress {
    from_port   = var.Port
    to_port     = var.Port
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_traffic]
  }
}