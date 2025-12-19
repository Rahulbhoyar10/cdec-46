variable "image_id" {
    default = "ami-0f5fcdfbd140e4ab7"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "key_pair" {
    default = "ohio-key"
}
variable "pub_sub" {
    default = "10.0.0.0/20"
}
