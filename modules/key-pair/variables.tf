variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "project_environment" {
    description = "The environment of the project (e.g., dev, staging, prod)"
    type        = string
}

variable "key_file" {
    description = "The public key file to be used for the key pair"
    type        = string
}