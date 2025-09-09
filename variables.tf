

variable "vpc_config" {

    description = "Extract the VPC CIDR range and name from the user"
    type = object({
      cidr_block = string
      name = string
    })
    validation {
      condition = can(cidrnetmask(var.vpc_config.cidr_block))
      error_message = "Invalid CIDR format - ${var.vpc_config.cidr_block}"
    }
  
}

variable "subnet_config" {
    description = "Get the CIDR range and Availabilty Zones for the subnets"
    type = map(object({
      cidr = string
      az = string 
      public = optional(bool, false)  # false is the default value
    }))

    validation {
      condition = alltrue([for subnet in var.subnet_config: can(cidrnetmask(subnet.cidr))])
      error_message = "value"
    }

}

