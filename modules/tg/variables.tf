variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "project_environment" {
    description = "The environment of the project (e.g., dev, prod)"
    type        = string
}

variable "name" {
    description = "The name of the target group"
    type        = string
}

variable "load_balancing_algorithm_type" {
    description = "The load balancing algorithm type"
    type        = string
}

variable "port" {
    description = "The port on which the target group is listening"
    type        = number
}

variable "protocol" {
    description = "The protocol for connections from clients to the load balancer"
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
}

variable "deregistration_delay" {
    description = "The amount of time for Elastic Load Balancing to wait before changing the state of a deregistering target"
    type        = number
}

variable "stickiness_type" {
    description = "The type of stickiness"
    type        = string
}

variable "cookie_duration" {
    description = "The time period, in seconds, during which requests from a client should be routed to the same target"
    type        = number
}

variable "health_check_enabled" {
    description = "Whether health checks are enabled"
    type        = bool
}

variable "healthy_threshold" {
    description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
    type        = number
}

variable "interval" {
    description = "The approximate amount of time, in seconds, between health checks of an individual target"
    type        = number
}

variable "path" {
    description = "The destination for the health check request"
    type        = string
}

variable "health_check_protocol" {
    description = "The protocol to use to connect with the target"
    type        = string
}

variable "unhealthy_threshold" {
    description = "The number of consecutive health check failures required before considering the target unhealthy"
    type        = number
}

variable "matcher" {
    description = "The HTTP codes to use when checking for a successful response from a target"
    type        = string
}
variable "timeout" {
    description = "The amount of time, in seconds, during which no response means a failed health check"
    type        = number
}