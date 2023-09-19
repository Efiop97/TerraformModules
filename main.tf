module "network" {
  source = "./Modules/network"


  availabilityZones = var.availabilityZones
  allTraffic        = var.allTraffic
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  SubnetCount       = var.SubnetCount
  common_tags       = var.common_tags

}

module "compute" {
  source = "./Modules/compute"


  common_tags   = var.common_tags
  AMI           = var.AMI
  instance_type = var.instance_type
  instanceCount = var.instanceCount
  Key           = var.Key
  Port          = var.Port
  userdata      = var.userdata
  allTraffic    = var.allTraffic

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.subnet_id
}
