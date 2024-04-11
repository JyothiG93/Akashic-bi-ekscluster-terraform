region              = "us-west-1"
vpcname             = "Akashic-Bi-Eks-Vpc"
vpc-cidr            = "10.0.0.0/16"
azs                 = ["us-west-1b", "us-west-1c"]
publicsubnet-cidrs  = ["10.0.0.0/20", "10.0.16.0/20"]
privatesubnet-cidrs = ["10.0.32.0/19", "10.0.64.0/19"]
enable              = "true"
clustername         = "Akashic-Bi-Eks-Cluster"
ami                 = "ami-05c969369880fa2c2"