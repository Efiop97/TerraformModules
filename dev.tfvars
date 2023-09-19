AMI               = "ami-0f844a9675b22ea32"
instance_type     = "t3a.micro"
Key               = "Igor-rsa-key"
availabilityZones = ["us-east-1a", "us-east-1b"]
allTraffic        = "0.0.0.0/0"
instanceCount     = 2
SubnetCount       = 2
Port              = 8080