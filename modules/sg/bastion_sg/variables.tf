variable "sg_ports" {
    description = "List of ports for the security group rules"
    type        = list(string)
}

variable "sg_id" {
    description = "Security group ID"
    type        = string
}

variable "referenced_security_group_id" {
    description = "Referenced security group ID"
    type        = string
}