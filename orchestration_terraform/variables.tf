# detail all variables, that contain sensitive information, in this file

variable "region_name" {
    type = string
    default = "eu-west-1"
}

variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_name" {
    type = string
    default = "eng122-fahim-tf-vpc"
}

variable "public_cidr_block" {
    type = string
    default = "10.0.4.0/24"
}

variable "public_name" {
    type = string
    default = "eng122-fahim-tf-public"
}

variable "private_cidr_block" {
    type = string
    default = "10.0.17.0/24"
}

variable "private_name" {
    type = string
    default = "eng122-fahim-tf-private"
}

variable "igw_name" {
    type = string
    default = "eng122-fahim-tf-igw"
}

variable "rt_cidr_block" {
    type = string
    default = "0.0.0.0/0"
}

variable "rt_name" {
    type = string
    default = "eng122-fahim-tf-public-rt"  
}

variable "ami_id" {
    type = string
    default = "ami-0e49f7d1071c110c6"  
}

variable "ec2_instance_type" {
    type = string
    default = "t2.micro"
}

variable "associate_ip_boolean" {
    type = bool
    default = true
}

variable "key" {
    type = string
    default = "eng122-fahim-tf-key"  
}

variable "app_name" {
    type = string
    default = "eng122-fahim-tf-app"  
}

variable "db_name" {
    type = string
    default = "eng122-fahim-tf-db"  
}

variable "controller_name" {
    type = string
    default = "eng122-fahim-tf-controller"  
}