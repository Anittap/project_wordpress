variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "project_environment" {
    description = "The environment of the project (e.g., dev, prod)"
    type        = string
}

variable "name" {
    description = "The name of the load balancer"
    type        = string
}

variable "type" {
    description = "Whether the load balancer is internal or external"
    type        = bool
}

variable "lb_type" {
    description = "The type of the load balancer (e.g., application, network)"
    type        = string
}

variable "sg_id" {
    description = "The security group ID"
    type        = string
}

variable "subnet_ids" {
    description = "The list of subnet IDs"
    type        = list(string)
}

variable "enable_deletion_protection" {
    description = "Whether to enable deletion protection"
    type        = bool
}

variable "https_listener_port" {
    description = "The port for the HTTPS listener"
    type        = number
}

variable "certificate_arn" {
    description = "The ARN of the SSL certificate"
    type        = string
}

variable "tg_arn" {
    description = "The ARN of the target group"
    type        = string
}

variable "http_listener_port" {
    description = "The port for the HTTP listener"
    type        = number
}

variable "domain_name" {
    description = "The domain name"
    type        = string
}

variable "zone_id" {
    description = "The ID of the Route 53 hosted zone"
    type        = string
}