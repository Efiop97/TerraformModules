variable "common_tags" {
  default = {
    owner           = "igorm"
    bootcamp        = "19"
    expiration_date = "01-01-2024"
  }
}

variable "AMI" {
  description = "The AMI to use for EC2 image"
  type        = string
}

variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "instanceCount" {
  description = "amount of instances"
  type        = number
}

variable "Key" {
  description = "The RSA key used to connect to the instance"
  type        = string
  sensitive = true
}
variable "Port" {
  description = "deployment port"
  type = number
}


variable "userdata" {
  description = "userdata that to install needed resources"
  default = <<EOF
        #!/bin/bash
        # Install Docker
        yum update -y
        yum install docker -y
        service docker start

        # Install Docker Compose
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose

        # Create Docker group and add user
        groupadd docker
        usermod -aG docker ec2-user
        docker pull adongy/hostname-docker
        EOF
}

variable "vpc_cidr" {
  description = "cidr block of the vpc"
  type =  string
  default = "10.0.0.0/16" 
}

variable "subnet_cidr" {
  description = "subnet cidr block"
  type = list(any)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "availabilityZones" {
  description = "availability zones"
  type        = list(any)
}

variable "allTraffic" {
  description = "Allow all traffic from the internet"
  type        = string
}

variable "SubnetCount" {
  description = "amount of instances"
  type        = number
}
