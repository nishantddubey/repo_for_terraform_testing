aws_region    = "us-east-1" #change region as per the requirement or leave it blank for default(mumbai)

#networking related variables update as per the requirement or leave it blank for default
vpc_name      = "vpc-tf"
public_subnet_name = "public-subnet"
private_subnet_name = "private-subnet"
internet_gateway_name = "my-igw"
route_table_name = "public-route-table"


#Instance related variables update as per the requirement or leave it blank for default
ami_id        = "ami-080e1f13689e07408"  #change ami id as per the region same ami has different id in different region
key_pair_name = "my_keypair_tf" 
instance_type = "t2.micro"
public_instance_name = "public-instance"
private_instance_name = "private-instance"
