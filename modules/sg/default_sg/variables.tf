variable "name" {
    description = "The name of the security group"
    type        = string
}

variable "description" {
    description = "The description of the security group"
    type        = string
}

variable "vpc_id" {
    description = "The VPC ID where the security group will be created"
    type        = string
}

variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "project_environment" {
    description = "The environment of the project (e.g., dev, prod)"
    type        = string
}

variable "sg_ports" {
    description = "A set of ports for the security group ingress rules"
    type        = list(string)
}

variable "ingress_cidr_ipv4" {
    description = "The CIDR block for ingress rules"
    type        = string
}

variable "egress_cidr_ipv4" {
    description = "The CIDR block for egress rules"
    type        = string
}

variable "egress_port" {
    description = "The port for egress rules"
    type        = string
}