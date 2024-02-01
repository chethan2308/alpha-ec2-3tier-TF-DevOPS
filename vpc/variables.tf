#vpc variables
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

#public subnet az1
variable "public_subnet_AZ1" {
  default = "10.0.0.0/24"
}

#public subnet az2
variable "public_subnet_AZ2" {
  default = "10.0.1.0/24"
}

#private app subnet az1
variable "private_app_subnet_az1" {
  default = "10.0.2.0/24"
}

#private app subnet az2
variable "private_app_subnet_az2" {
  default = "10.0.3.0/24"
}

#private data subnet az1
variable "private_data_subnet_az1" {
  default = "10.0.4.0/24"
}

#private data subnet az2
variable "private_data_subnet_az2" {
  default = "10.0.5.0/24"
}

#ssh security group variable

variable "ssh_ip" {
  default = ["0.0.0.0/0"]

}

variable "ssl-cert" {
  default = ""

}