variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "project_environment" {
    description = "The environment of the project (e.g., dev, prod)"
    type        = string
}

variable "public_subnet_id" {
    description = "The ID of the public subnet"
    type        = string
}