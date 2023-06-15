locals {
    region = var.aws_region
    aws_region = locals.region
}

terraform {
    backend "s3" {
        bucket = "wy-a4f84a230c77"
        key    = "terraform.tfstate"
        region = local.aws_region
    }
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 3.0.0"
        }
    }
}

provider "aws" {
    region = local.aws_region
}


module "vpc" {
    source = "./vpc"
}

module "alb" {
    source     = "./alb"
    vpc_id     = module.vpc.vpc_id
    aws_subnet = module.vpc.aws_subnet

    default_security_group_id = module.vpc.default_security_group_id
}

module "ec2" {
    source = "./ec2"
    vpc_id = module.vpc.vpc_id
    alb_id = module.alb.alb_id

    default_security_group_id = module.vpc.default_security_group_id
}
