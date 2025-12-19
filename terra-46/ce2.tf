#<BLOCK_TYPE> <RESOURCE_TYPE> <BLOCK_NAME>


provider "aws" {
    region = "us-west-2"

}



resource "aws_security_group" "my-sg"{

    name = "my-sg"
    description = "Allow TLS inbound traffic and all outbound traffic"


     tags = {
    Name = "my-sg"
  }


    ingress {

        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"] 

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks= ["0.0.0.0/0"]
    }
}


resource "aws_instance" "my-ce2" {
   ami = var.image_id
   instance_type = var.instance_type
   key_name = var.key_pair
   #security_groups = ["default"]
   vpc_security_group_ids = [aws_security_group.my-sg.id]

   user_data = <<-EOF
   #!/bin/bash
   sudo yum update -y
   sudo yum install httpd -y
   sudo systemctl start httpd
   sudo systemctl enable httpd

   EOF

   tags = {

    Name= "my-tf-server"
   }


}


output "instance_public_ip"{
    value = aws_instance.my-ce2.public_ip
}


variable "image_id"{
    type= string
    default = "ami-0ebf411a80b6b22cb"
}

variable "instance_type" {
    default =  "t3.micro"
}


variable "key_pair" {
    default = "ore-new"
}





resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_sub
   map_public_ip_on_launch = true


  tags = {
    Name = "pub-sub"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_default_route_table" "main-rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

 

  tags = {
    Name = "main-rt"
  }
}

resource "aws_instance" "my-ce2" {
   ami = var.image_id
   instance_type = var.instance_type
   key_name = var.key_pair
   #security_groups = ["default"]
   vpc_security_group_ids = [aws_security_group.my-sg.id]
   subnet_id = aws_subnet.main.id




resource "aws_security_group" "my-sg"{

    name = "my-sg"
    description = "Allow TLS inbound traffic and all outbound traffic"
    vpc_id = aws_vpc.main.id


     tags = {
    Name = "my-sg"
  }


    ingress {

        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"] 

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks= ["0.0.0.0/0"]
    }
}

module "vpc-module-basic"{
    source = 
}




