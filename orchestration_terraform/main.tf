# specify cloud service provider and region
provider "aws" {
    region = var.region_name
}

# resource to make the vpc
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block

    tags = {
      "Name" = var.vpc_name
    }
}

# resource to make the public subnet
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id   # connecting the to the vpc made in "main" resource
    cidr_block = var.public_cidr_block

    tags = {
      "Name" = var.public_name
    }
}

# resource to make the the private subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id   # can also just assign the id of the chosen vpc
    cidr_block = var.private_cidr_block

    tags = {
      "Name" = var.private_name
    }  
}

# resource to make an internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        "Name" = var.igw_name
    }  
}

# resource to make a route table for the public subnet
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = var.rt_cidr_block
        gateway_id = aws_internet_gateway.igw.id
    }  

    tags = {
      "Name" = var.rt_name
    }
}

# resource to connect the public route table and public subnet
resource "aws_route_table_association" "public-rt-public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public-rt.id  
}

# resources to create an ec2 instances
resource "aws_instance" "app_instance" {
    ami = var.ami_id

    instance_type = var.ec2_instance_type

    associate_public_ip_address = var.associate_ip_boolean

    subnet_id = aws_subnet.public.id

    tags = {
      "Name" = var.app_name
    }

    key_name = var.key

}

resource "aws_instance" "db_instance" {
    ami = var.ami_id

    instance_type = var.ec2_instance_type

    associate_public_ip_address = var.associate_ip_boolean

    subnet_id = aws_subnet.private.id

    tags = {
      "Name" = var.db_name
    }

    key_name = var.key

}

resource "aws_instance" "controller_instance" {
    ami = var.ami_id

    instance_type = var.ec2_instance_type

    associate_public_ip_address = var.associate_ip_boolean

    subnet_id = aws_subnet.public.id

    tags = {
      "Name" = var.controller_name
    }

    key_name = var.key

}