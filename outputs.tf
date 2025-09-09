

output "vpc_id" {
    value = aws_vpc.custom_vpc.id
  
}


output "subnet_ids" {
    value = {for k, v in aws_subnet.subnets : k => v.id}
  
}


output "availability_zones" {
    value = {for k, v in aws_subnet.subnets : k => v.availability_zone}
  
}


output "subnet_info" {
    value = aws_subnet.subnets
  
}