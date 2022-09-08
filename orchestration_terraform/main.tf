# who is the cloud service provider- aws
provider "aws" {

# within which cloud service provider region- eu-west-1
    region = "eu-west-1"

}

# create a block of code to launch ec2-server

# which resource do we like to create
resource "aws_instance" "app_instance" {

# which ami
    ami = "ami-0b47105e3d7fc023e"

# which instance type
    instance_type = "t2.micro"

# do we need it to have public ip
    associate_public_ip_address = true

# how to name your instance
    tags = {
      "Name" = "eng122-fahim-tf-app"
    }

# how to add ssh connection to instance
    key_name = "eng122-fahim-tf-key"

}