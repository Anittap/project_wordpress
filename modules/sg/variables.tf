variable "project_name" {
  type        = string
  description = "project namliste"
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "name" {
  type        = string
  description = "sg name"
}
variable "description" {
  type        = string
  description = "sg description"
}
variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "sg_ports" {
  type        = list(string)
  description = "sg ports"
}
variable "sg_reference_id" {
  type        = string
  description = "sg reference id"
}
variable "egress_cidr_ipv4" {
  type        = string
  description = "egress cidr ipv4"
}
variable "egress_port" {
  type        = string
  description = "egress port"
}
variable "sg_ports" {
  type        = list(string)
  description = "List of security group ports"
}

variable "sg_reference_id" {
  type        = string
  description = "Referenced security group ID"
}

variable "egress_cidr_ipv4" {
  type        = string
  description = "Egress CIDR IPv4"
}

variable "egress_port" {
  type        = string
  description = "Egress port"
}