variable "region" {
  type        = string
  description = "aws region"
}

variable "project_name" {
  type        = string
  description = "project name"
}
variable "owner" {
  type        = string
  description = "project owner "
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "bits" {
  type        = string
  description = "subnet bits"
}
variable "wp_cidr_block" {
  type        = string
  description = "cidr block for wp vpc"
}
variable "db_cidr_block" {
  type        = string
  description = "cidr block for db vpc"
}
variable "lb_sg_ports" {
  type        = list(string)
  description = "lb sg ports"
}
variable "wp_sg_ports" {
  type        = list(string)
  description = "wp sg ports"
}
variable "db_sg_ports" {
  type        = list(string)
  description = "db sg ports"
}
variable "domain_name" {
  type        = string
  description = "domain name"
}
variable "lb_ingress_cidr_ipv4" {
  type        = string
  description = "Ingress CIDR blocks for load balancer"
}

variable "lb_egress_cidr_ipv4" {
  type        = string
  description = "Egress CIDR blocks for load balancer"
}

variable "lb_egress_port" {
  type        = string
  description = "Egress port for load balancer"
}
variable "wp_egress_cidr_ipv4" {
  type        = string
  description = "Egress CIDR blocks for WordPress"
}

variable "wp_egress_port" {
  type        = string
  description = "Egress port for WordPress"
}

variable "db_egress_cidr_ipv4" {
  type        = string
  description = "Egress CIDR blocks for database"
}

variable "db_egress_port" {
  type        = string
  description = "Egress port for database"
}
variable "wp_max_size" {
  type        = number
  description = "Maximum size of the WordPress ASG"
}

variable "wp_min_size" {
  type        = number
  description = "Minimum size of the WordPress ASG"
}

variable "wp_desired_size" {
  type        = number
  description = "Desired size of the WordPress ASG"
}

variable "wp_health_check_grace_period" {
  type        = number
  description = "Health check grace period for the WordPress ASG"
}

variable "wp_enable_elb_health_checks" {
  type        = map(any)
  description = "Enable ELB health checks for the WordPress ASG"
}
variable "instance_type" {
  type        = map(any)
  description = "map of instance type"
}
variable "db_name" {
  type        = string
  description = "Database name"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage for the database"
}

variable "storage_type" {
  type        = string
  description = "Storage type for the database"
}

variable "engine" {
  type        = string
  description = "Database engine"
}

variable "engine_version" {
  type        = string
  description = "Database engine version"
}

variable "instance_class" {
  type        = string
  description = "Database instance class"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
}
variable "load_balancing_algorithm_type" {
  type        = string
  description = "Load balancing algorithm type"
}

variable "port" {
  type        = number
  description = "Port for the target group"
}

variable "protocol" {
  type        = string
  description = "Protocol for the target group"
}

variable "deregistration_delay" {
  type        = number
  description = "Deregistration delay for the target group"
}

variable "stickiness_type" {
  type        = string
  description = "Stickiness type for the target group"
}

variable "cookie_duration" {
  type        = number
  description = "Cookie duration for the target group"
}

variable "health_check_enabled" {
  type        = bool
  description = "Enable health checks for the target group"
}

variable "healthy_threshold" {
  type        = number
  description = "Healthy threshold for the target group"
}

variable "interval" {
  type        = number
  description = "Interval for health checks"
}

variable "path" {
  type        = string
  description = "Path for health checks"
}

variable "health_check_protocol" {
  type        = string
  description = "Protocol for health checks"
}

variable "unhealthy_threshold" {
  type        = number
  description = "Unhealthy threshold for the target group"
}
variable "matcher" {
  type        = string
  description = "Matcher for the target group"
}
variable "lb_type" {
  type        = string
  description = "Load balancer type"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection for the load balancer"
}

variable "https_listener_port" {
  type        = number
  description = "HTTPS listener port for the load balancer"
}
variable "http_listener_port" {
  type        = number
  description = "HTTP listener port for the load balancer"
}
variable "type" {
  type        = bool
  description = "Type of the load balancer"
}
variable "private_zone_name" {
  type        = string
  description = "Private zone name"
}