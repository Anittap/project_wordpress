
variable "ami" {
type        = string
description = "ami"
}
variable "instance_type" {
type        = string
description = "instance type"
}
variable "key_name" {
type        = string
description = "key name"
}
variable "public_subnet_id" {
type        = string
description = "public subnet id"
}
variable "security_group_id" {
type        = string
description = "security group_id"
}
variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "project_environment" {
  description = "The environment of the project (e.g., dev, prod)"
  type        = string
}
    
    