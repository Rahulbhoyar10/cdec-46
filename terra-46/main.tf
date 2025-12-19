provider "aws" {
    region = "us-east-2"

}


module "vpc-module-basic"{
    source = "./modules/vpc-tf/"
}

