provider "aws" {
    region = "us-east-2"

}


module "vpc-module-basic"{
    source = "./modules/vpc-tf/"
}



terraform {
  backend "s3" {
    bucket         = "docker-buck-000999"
    key            = "prod/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "my-first-table"
  }
}