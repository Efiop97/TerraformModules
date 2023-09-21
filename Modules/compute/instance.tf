resource "aws_instance" "ec2" {
  count                  = var.instanceCount
  ami                    = var.AMI
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id[count.index]
  vpc_security_group_ids = [aws_security_group.sec_group.id]

  key_name = var.Key

  user_data = <<-EOF
    ${var.userdata}
    docker run -d -p ${var.Port}:3000 adongy/hostname-docker
  EOF
  
  tags = {
    Name = "igor-Easy${count.index + 1}"
  }
}

