


resource "aws_vpc" "custom_vpc" {
    cidr_block = var.vpc_config.cidr_block
    tags = {
        Name = var.vpc_config.name
    }
  
}


resource "aws_subnet" "subnets" {
    vpc_id = aws_vpc.custom_vpc.id
    for_each = var.subnet_config
    cidr_block = each.value.cidr
    availability_zone = each.value.az
    tags = {
        Name = each.key
    }
  
}

locals {
  public_subnet_count = [for key, value in var.subnet_config: key if value.public == true]
}

# Create an internet gateway if there is atleast one public subnet
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.custom_vpc.id
    count = length(local.public_subnet_count) > 0 ? 1 : 0
    }
  


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
    
  }
}


resource "aws_route_table_association" "public_rt_assoc" {
    route_table_id = aws_route_table.public_rt.id
    for_each = toset(local.public_subnet_count)
    subnet_id = aws_subnet.subnets[each.key].id
  
}



