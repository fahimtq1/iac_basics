# specify cloud service provider and region
provider "aws" {
    region = "eu-west-1"
}

# resource to make the vpc
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
      "Name" = "eng122-fahim-tf-vpc"
    }
}

# resource to make the public subnet
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id   # connecting the to the vpc made in "main" resource
    cidr_block = "10.0.4.0/24"

    tags = {
      "Name" = "eng122-fahim-tf-public"
    }
}

# resource to make the the private subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id   # can also just assign the id of the chosen vpc
    cidr_block = "10.0.17.0/24"

    tags = {
      "Name" = "eng122-fahim-tf-private"
    }  
}

# resource to make an internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        "Name" = "eng122-fahim-tf-igw"
    }  
}

# resource to make a route table for the public subnet
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }  

    tags = {
      "Name" = "eng122-fahim-tf-public-rt"
    }
}

# resource to connect the public route table and public subnet
resource "aws_route_table_association" "public-rt-public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public-rt.id  
}

# resource to create an ec2 instance
resource "aws_instance" "app_instance" {
    ami = "ami-0d28346e264907026"

    instance_type = "t2.micro"

    associate_public_ip_address = true

    subnet_id = aws_subnet.public.id

    tags = {
      "Name" = "eng122-fahim-tf-app"
    }

    key_name = "eng122-fahim-tf-key"

}