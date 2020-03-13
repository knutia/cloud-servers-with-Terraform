variable "environment" {
  default = "staging"
}

variable "location" {
  description = "The location that the resources will be launched"
}
variable "key_name" {
  description = "The aws keypair to use"
}

# Networking

variable "vpc_cidr" {
  description = "The CIDR block of the VNET"
}

variable "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
}

/* 
variable "region" {
  description = "Region that the instances will be created"
} */



/* variable "availability_zone" {
  description = "The AZ that the resources will be launched"
}
 */
