variable "zone_id" {
    description = "The ID of the VPC"
    type        = string
}

variable "rds_record_name" {
    description = "The name of the RDS CNAME record"
    type        = string
}

variable "rds_endpoint" {
    description = "The endpoint of the RDS instance"
    type        = string
}
variable "project_name" {
    description = "The name of the project"
    type        = string
}

variable "domain_name" {
    description = "The domain name"
    type        = string
}

variable "lb_dns_name" {
    description = "The DNS name of the load balancer"
    type        = string
}

variable "lb_zone_id" {
    description = "The zone ID of the load balancer"
    type        = string
}
