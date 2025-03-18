variable "private_zone_name" {
    description = "The name of the private hosted zone"
    type        = string
}

variable "vpc_id" {
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