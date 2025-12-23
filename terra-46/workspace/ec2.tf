
provider "aws"{
    region = "us-east-2"
}




resource "aws_instance" "ec2" {
    for_eac = var.instance_type
    ami = "ami-0f5fcdfbd140e4ab7"
    instance_type = each.value
    key_name = "ohio-key"
    security_groups = ["default"]
    # count = 3
    tags = {
        # ENV = dev
        Name = "my-workspace-instance-${each.key}"
    }
}

variable "instance_type" {
    default = {
        small = "t2.small"
        micro = "t3.micro"
        nano = "t2.nano"
    }
}