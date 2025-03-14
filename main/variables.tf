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