variable "name" {
    description = "The name of the Auto Scaling group"
    type        = string
}

variable "max_size" {
    description = "The maximum size of the Auto Scaling group"
    type        = number
}

variable "min_size" {
    description = "The minimum size of the Auto Scaling group"
    type        = number
}

variable "health_check_grace_period" {
    description = "The health check grace period for the Auto Scaling group"
    type        = number
}

variable "enable_elb_health_checks" {
    description = "Map of project environments to enable ELB health checks"
    type        = map(any)
}

variable "project_environment" {
    description = "The project environment"
    type        = string
}

variable "desired_size" {
    description = "The desired capacity of the Auto Scaling group"
    type        = number
}

variable "private_subnets" {
    description = "List of private subnets for the Auto Scaling group"
    type        = list(string)
}

variable "lt_id" {
    description = "The ID of the launch template"
    type        = string
}

variable "lt_version" {
    description = "The version of the launch template"
    type        = string
}
variable "project_name" {
    description = "The name of the project"
    type        = string
}