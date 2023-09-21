variable "common_tags" {
  default = {
    owner           = "igorm"
    bootcamp        = "19"
    expiration_date = "01-01-2024"
  }
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

variable "all_traffic" {
  description = "Allow all traffic from the internet"
  type        = string
}

variable "SubnetCount" {
  description = "amount of instances"
  type        = number
}

