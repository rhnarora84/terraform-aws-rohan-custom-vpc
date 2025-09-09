# terraform-aws-vpc

## Overview
This Terraform module helps you create a custom VPC with CIDR block of your own choice. It also creates multiple subnets (public and private), and an Internet Gateway to be linked with the public subnets.


 ## Features
 - Creates a VPC with a specified CIDR block
 - Creates public and private subnets
 - Create an Internet Gateway for public subnets
 - Create and configure route tables for public subnets

## Usage
```
module "vpc" {
    source = "./module/vpc"

    vpc_config = {
      cidr_block = "10.0.0.0/16"
      name = "custom_vpc"
    }

    subnet_config = {
        "public_subnet_01" = {
            cidr = "10.0.1.0/24"
            az = "eu-central-1a" 
            public = true
        }

         "public_subnet_02" = {
            cidr = "10.0.2.0/24"
            az = "eu-central-1b" 
            public = true
        }

          "private_subnet_01" = {
            cidr = "10.0.3.0/24"
            az = "eu-central-1a" 
            public = false
        }

         "private_subnet_02" = {
            cidr = "10.0.4.0/24"
            az = "eu-central-1b" 
            public = false
        }

      
    }
  
}

```