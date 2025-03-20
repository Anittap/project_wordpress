variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "project_environment" {
    description = "The environment of the project (e.g., dev, prod)"
    type        = string
}

variable "private_subnet_ids" {
    description = "List of private subnet IDs"
    type        = list(string)
}

variable "efs_sg_id" {
    description = "The security group ID for the EFS"
    type        = string
}