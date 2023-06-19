locals {
    aws_region = var.aws_region
}

terraform {
    backend "s3" {
        bucket = "wy-a4f84a230c77"
        key    = "terraform.tfstate"
        region = "us-west-2"
    }
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 3.0.0"
        }
    }
}

# I needed to add this shared config files and credential to get the aws provider to work
# because the path was not being recognized. This ~/.aws/config and ~/.aws/credentials are the path of the
# files on my local machine (WSL on Windows 11)

provider "aws" {
    region = local.aws_region
    shared_config_files      = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
}
module "vpc" {
    source = "./vpc"
}
module "alb" {
    source     = "./alb"
    vpc_id     = module.vpc.vpc_id
    aws_subnet_public = module.vpc.aws_subnet_public
    ec2_1_id   = module.ec2.ec2_1_id
    ec2_2_id   = module.ec2.ec2_2_id

    alb_sg = module.sg.alb_sg
}

module "ec2" {
    source = "./ec2"

    aws_subnet_private = module.vpc.aws_subnet_private
    aws_subnet_public  = module.vpc.aws_subnet_public

    ec2_sg     = module.sg.ec2_sg
    bastion_sg = module.sg.bastion_sg
}

module "sg" {
    source = "./sg"

    vpc_id = module.vpc.vpc_id
}
