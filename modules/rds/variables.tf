variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "subnet_ids" {
    description = "A list of subnet IDs"
    type        = list(string)
}
variable "db_name" {
    description = "The name of the RDS database"
    type        = string
}

variable "allocated_storage" {
    description = "The allocated storage for the RDS instance"
    type        = number
}

variable "storage_type" {
    description = "The storage type for the RDS instance"
    type        = string
}

variable "engine" {
    description = "The database engine to use"
    type        = string
}

variable "engine_version" {
    description = "The version of the database engine"
    type        = string
}

variable "instance_class" {
    description = "The instance class for the RDS instance"
    type        = string
}

variable "db_username" {
    description = "The username for the RDS instance"
    type        = string
}

variable "db_password" {
    description = "The password for the RDS instance"
    type        = string
    sensitive   = true
}

variable "sg_id" {
    description = "The security group ID for the RDS instance"
    type        = string
}