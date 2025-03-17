variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "project_environment" {
  description = "The environment of the project (e.g., dev, prod)"
  type        = string
}

variable "name" {
  description = "The name for the launch template"
  type        = string
}
variable "ami_id" {
  description = "The AMI ID to use for the instances"
  type        = string
}

variable "key_pair" {
  description = "The key pair to use for the instances"
  type        = string
}

variable "sg_id" {
  description = "The security group ID to associate with the instances"
  type        = string
}