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