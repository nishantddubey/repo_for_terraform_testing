# Credientials of AWS 
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  default = "ap-south-1" #default is mumbai region
}


#variables used to create vpc
variable "vpc_name" {
  description = "The name of your VPC"
  default = "myvpc"
}

variable "public_subnet_name" {
  description = "The name of public subnet"
  default = "public-subnet"
}

variable "private_subnet_name" {
  description = "The name of public subnet"
  default = "private-subnet"
}
variable "internet_gateway_name" {
  description = "The name of internet Gateway"
  default = "my-igw"
}
variable "route_table_name" {
  description = "The name of Route table"
  default = "public-route-table"
}


#variables used to create instance
variable "ami_id" {
  description = "The ID of the AMI to use for EC2 instances"
  default = "ami-007020fd9c84e18c7" #ubuntu image of mumbai region
}

variable "instance_type" {
  description = "The type of instance which will get created"
  default = "t3.micro"
  
}

variable "key_pair_name" {
  description = "The name of the AWS Key Pair used to SSH into the EC2 instances"
  default = "my-keypair"
}

variable "public_instance_name" {
  description = "The  name of Public instance"
  default = "public-instance"
}

variable "private_instance_name" {
  description = "The  name of private instance"
  default = "private-instance"
}

#variables used for creating security groups

variable "ssh_cidr" {
  description = "CIDR block for SSH access"
  default     = "0.0.0.0/0"
}

variable "http_cidr" {
  description = "CIDR block for HTTP access"
  default     = "0.0.0.0/0"
}

variable "security_group_tags" {
  description = "Map of security group tags"
  default = {
    public_ssh   = { name = "public-ssh", description = "Security group for public EC2 instance SSH access" }
    public_http  = { name = "public-http", description = "Security group for public EC2 instance HTTP access" }
    private_ssh  = { name = "private-ssh", description = "Security group for private EC2 instance SSH access" }
    private_http = { name = "private-http", description = "Security group for private EC2 instance HTTP access" }
  }
}

